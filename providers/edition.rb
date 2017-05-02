
#
# Author:: Ian Kendrick (<iankendrick@gmail.com>), Shawn Neal (<sneal@sneal.net>)
# Cookbook Name:: visualstudio
# Provider:: edition
#
# Copyright 2015, Ian Kendrick, Shawn Neal
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

require 'fileutils'
require 'chef/mixin/deep_merge'

include Windows::Helper
include Visualstudio::Helper
include Chef::Mixin::DeepMerge

def whyrun_supported?
  true
end

use_inline_resources

action :install do
  unless package_is_installed?(new_resource.package_name)
    converge_by("Installing VisualStudio #{new_resource.edition} #{new_resource.version}") do
      # Extract the ISO image to the temporary Chef cache dir
      seven_zip_archive "extract_#{new_resource.version}_#{new_resource.edition}_iso" do
        path extracted_iso_dir
        source new_resource.source
        overwrite true
        checksum new_resource.checksum
        only_if { !new_resource.source.nil? and extractable_download }
      end

      # Not an ISO but the web install
      remote_file "download__#{new_resource.version}_#{new_resource.edition}" do
        path installer_exe
        source lazy { new_resource.source }
        checksum new_resource.checksum
        only_if { !new_resource.source.nil? and !extractable_download }
      end

      # Ensure the target directory exists so logging doesn't fail on VS 2010
      directory "create_#{new_resource.install_dir}" do
        path new_resource.install_dir
        recursive true
      end

      windows_package new_resource.package_name do
        source installer_exe
        installer_type :custom
        options visual_studio_options
        timeout 3600 # 1hour
        returns [0, 127, 3010]
      end

      # Cleanup extracted ISO files from tmp dir
      directory "remove_#{new_resource.version}_#{new_resource.edition}_dir" do
        path extracted_iso_dir
        action :delete
        recursive true
        only_if { !new_resource.source.nil? and !new_resource.preserve_extracted_files }
      end
    end
    new_resource.updated_by_last_action(true)
  end
end

def extractable_download
  ::File.extname(new_resource.source).casecmp('.iso').zero? || ::File.extname(new_resource.source).casecmp('.zip').zero? || ::File.extname(new_resource.source).casecmp('.7z').zero?
end

def prepare_vs_options
  config_path = create_vs_admin_deployment_file
  setup_options = "/Q /norestart /noweb /log \"#{install_log_file}\" /adminfile \"#{config_path}\""
  if new_resource.product_key
    product_key = new_resource.product_key.delete('-')
    setup_options << " /productkey \"#{product_key}\""
  end
  setup_options
end

# rubocop:disable Metrics/LineLength, Metrics/MethodLength, Metrics/AbcSize
def create_vs_admin_deployment_file
  config_path = win_friendly_path(::File.join(extracted_iso_dir, 'AdminDeployment.xml'))

  # Merge the VS version and edition default AdminDeploymentFile.xml item's with customized install_items
  install_items = deep_merge(node['visualstudio'][new_resource.version.to_s][new_resource.edition.to_s]['default_install_items'], Mash.new)
  install_items = deep_merge(node['visualstudio']['install_items'], install_items)

  template config_path do
    source 'AdminDeployment.xml.erb'
    variables(
      items: install_items,
      version: new_resource.version.to_s,
      edition: new_resource.edition
    )
  end
  config_path
end

def prepare_vs2010_options
  if new_resource.configure_basename.nil?
    '/q'
  else
    "/unattendfile \"#{create_vs2010_unattend_file}\""
  end
end

def create_vs2010_unattend_file
  config_path = win_friendly_path(::File.join(extracted_iso_dir, new_resource.configure_basename))

  template "#{config_path}.tmp" do
    source "#{new_resource.configure_basename}.erb"
    action :create
    variables 'extracted_iso_dir' => extracted_iso_dir.downcase
  end

  # chef creates utf-8 ini file but VS expects unicode, so convert
  utf8_to_unicode(config_path)
  config_path
end

def prepare_vs2017_options
  option_all = node['visualstudio'][new_resource.version.to_s]['all']
  option_all_workloads = node['visualstudio'][new_resource.version.to_s]['allWorkloads']
  option_include_recommended = node['visualstudio'][new_resource.version.to_s]['includeRecommended']
  option_include_optional = node['visualstudio'][new_resource.version.to_s]['includeOptional']
  options_components_to_install = ''

  # Merge the VS version and edition default AdminDeploymentFile.xml item's with customized install_items  
  node['visualstudio'][new_resource.version.to_s][new_resource.edition.to_s]['default_install_items'].each do |key, attributes|
    if attributes.has_key?('selected')
      if attributes['selected']
        options_components_to_install << " --add #{key}"
      end
    end
  end

  setup_options = '--norestart --passive --wait'
  setup_options << " --installPath \"#{new_resource.install_dir}\"" unless new_resource.install_dir.empty?
  setup_options << ' --all' if option_all
  setup_options << ' --allWorkloads' if option_all_workloads
  setup_options << ' --includeRecommended' if option_include_recommended
  setup_options << ' --includeOptional' if option_include_optional
  setup_options << options_components_to_install unless options_components_to_install.empty?

  setup_options
end

def utf8_to_unicode(file_path)
  powershell_script "convert #{file_path} to unicode" do
    code(
      "gc -en utf8 #{file_path}.tmp | Out-File -en unicode #{file_path}"
    )
  end
end

def install_log_file
  win_friendly_path(::File.join(new_resource.install_dir, 'vsinstall.log'))
end

def visual_studio_options
  if new_resource.version == '2010'
    return prepare_vs2010_options
  elsif new_resource.version == '2017'
    return prepare_vs2017_options
  else
    return prepare_vs_options
  end 
end

def installer_exe
  installer = new_resource.installer_file || "vs_#{new_resource.edition}.exe"
  installer = ::File.join(extracted_iso_dir, installer) unless new_resource.source.nil?
  installer
end

def extracted_iso_dir
  default_path = ::File.join(
    Chef::Config[:file_cache_path],
    new_resource.version,
    new_resource.edition
  )
  extract_dir = node['visualstudio']['unpack_dir'].nil? ? default_path : node['visualstudio']['unpack_dir']
  win_friendly_path(extract_dir)
end
