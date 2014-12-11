#
# Author:: Shawn Neal <sneal@daptiv.com>
# Cookbook Name:: visualstudio
# Recipe:: install
#
# Copyright 2013, Daptiv Solutions, LLC.
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

::Chef::Recipe.send(:include, Visualstudio::Helper)


[*(node['visualstudio']['edition'])].each do |edition|
  install_dir = attribute_from_edition_or_cookbook(edition, 'install_dir')
  vs_is_installed = is_vs_installed?(install_dir)

  source = attribute_from_edition_or_cookbook(edition, 'source')
  install_url = File.join(source, node['visualstudio'][edition]['filename'])
  install_log_file = win_friendly_path(File.join(install_dir, 'vsinstall.log'))

  iso_extraction_dir = win_friendly_path(
    File.join(Chef::Config[:file_cache_path], 'vs2012', edition))
  setup_exe_path = File.join(iso_extraction_dir, node['visualstudio'][edition]['installer_file'])
  configure_basename = node['visualstudio'][edition]['config_file'] || 'AdminDeployment.xml'
  configuration_file = win_friendly_path(File.join(iso_extraction_dir, configure_basename))

  # Extract the ISO image to the tmp dir
  seven_zip_archive 'extract_vs2012_iso' do
    path iso_extraction_dir
    source install_url
    overwrite true
    checksum node['visualstudio'][edition]['checksum']
    not_if { vs_is_installed }
  end

  conf_source = node['visualstudio'][edition]['config_file'] ||
    'AdminDeployment-' + edition + '.xml'

  # Create installation config file
  cookbook_file configuration_file do
    source conf_source
    action :create
    not_if { vs_is_installed }
  end

  Install Visual Studio
  windows_package node['visualstudio'][edition]['package_name'] do
    source setup_exe_path
    installer_type :custom
    if node['visualstudio'][edition]['config_file'] =~ /unattend/
      options "/Q /norestart /Log \"#{install_log_file}\" /unattendfile \"#{configuration_file}\""
    else
      options "/Q /norestart /Log \"#{install_log_file}\" /AdminFile \"#{configuration_file}\""
    end
    notifies :delete, "directory[#{iso_extraction_dir}]"
    timeout 3600 # 1hour
    not_if { vs_is_installed }
  end

  # Cleanup extracted ISO files from tmp dir
  directory iso_extraction_dir do
    action :nothing
    recursive true
    not_if { node['visualstudio']['preserve_extracted_files'] }
  end
end
