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

vs_is_installed = is_vs_installed?()

# Ensure the installation ISO url has been set by the user
if !node['visualstudio']['source']
  raise 'visualstudio source attribute must be set before running this cookbook'
end

edition = node['visualstudio']['edition']
install_url = File.join(node['visualstudio']['source'], node['visualstudio'][edition]['filename'])
install_log_file = win_friendly_path(
  File.join(node['visualstudio']['install_dir'], 'vsinstall.log'))

iso_extraction_dir = win_friendly_path(File.join(Chef::Config[:file_cache_path], 'vs2012'))
setup_exe_path = File.join(iso_extraction_dir, node['visualstudio'][edition]['installer_file'])
admin_deployment_xml_file = win_friendly_path(File.join(iso_extraction_dir, 'AdminDeployment.xml'))

# Extract the ISO image to the tmp dir
seven_zip_archive 'extract_vs2012_iso' do
  path iso_extraction_dir
  source install_url
  overwrite true
  checksum node['visualstudio'][edition]['checksum']
  not_if { vs_is_installed }
end

# Create installation config file
cookbook_file admin_deployment_xml_file do
  source 'AdminDeployment-' + edition + '.xml'
  action :create
  not_if { vs_is_installed }
end

# Install Visual Studio
windows_package node['visualstudio'][edition]['package_name'] do
  source setup_exe_path
  installer_type :custom
  options "/Q /norestart /Log \"#{install_log_file}\" /AdminFile \"#{admin_deployment_xml_file}\""
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
