#
# Author:: Ian Kendrick (<iankendrick@gmail.com>), Shawn Neal (<sneal@daptiv.com>)
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

include Windows::Helper
include Visualstudio::Helper

def whyrun_supported?
  true
end

action :install do
  unless package_is_installed?(new_resource.package_name)
    converge_by("Installing VisualStudio #{new_resource.edition} #{new_resource.version}") do

      # Extract the ISO image to the temporary Chef cache dir
      seven_zip_archive "extract_#{new_resource.version}_#{new_resource.edition}_iso" do
        path extracted_iso_dir
        source new_resource.source
        overwrite true
        checksum new_resource.checksum
      end

      # Ensure the target directory exists so logging doesn't fail on VS 2010
      FileUtils::mkdir_p new_resource.install_dir

      # Install Visual Studio
      setup_options = new_resource.version == '2010' ? prepare_vs2010_options : prepare_vs_options

      windows_package new_resource.package_name do
        source installer_exe
        installer_type :custom
        options setup_options
        timeout 3600 # 1hour
        success_codes [0, 127, 3010]
      end

      # Cleanup extracted ISO files from tmp dir
      directory "remove_#{new_resource.version}_#{new_resource.edition}_dir" do
        path extracted_iso_dir
        action :delete
        recursive true
        not_if { new_resource.preserve_extracted_files }
      end
    end
    new_resource.updated_by_last_action(true)
  end
end

def prepare_vs_options
  config_source = "#{new_resource.version}/AdminDeployment-#{new_resource.edition}.xml"
  config_path = win_friendly_path(::File.join(extracted_iso_dir, 'AdminDeployment.xml'))

  # Create installation config file
  cookbook_file config_path do
    source config_source
    action :create
  end

  setup_options = "/Q /norestart /noweb /log \"#{install_log_file}\" /adminfile \"#{config_path}\""
  if new_resource.product_key
    product_key = new_resource.product_key.delete('-')
    setup_options << " /productkey \"#{product_key}\""
  end
  setup_options
end

def prepare_vs2010_options
  config_path = win_friendly_path(::File.join(extracted_iso_dir, new_resource.configure_basename))

  template "#{config_path}.tmp" do
    source "#{new_resource.configure_basename}.erb"
    action :create
    variables 'extracted_iso_dir' => extracted_iso_dir.downcase
  end

  # chef creates utf-8 ini file but VS expects unicode, so convert
  powershell_script 'convert unattend.ini to unicode' do
    code(
      "gc -en utf8 #{config_path}.tmp | Out-File -en unicode #{config_path}"
    )
  end

  setup_options = "/unattendfile \"#{config_path}\""
  setup_options
end

def install_log_file
  win_friendly_path(::File.join(new_resource.install_dir, 'vsinstall.log'))
end

def installer_exe
  installer = new_resource.installer_file || "vs_#{new_resource.edition}.exe"
  ::File.join(extracted_iso_dir, installer)
end

def extracted_iso_dir
  win_friendly_path(
    ::File.join(
      Chef::Config[:file_cache_path],
      new_resource.version,
      new_resource.edition))
end
