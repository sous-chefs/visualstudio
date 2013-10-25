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

# Ensure 7-zip is installed
include_recipe '7-zip::default'

# Ensure the installation ISO url has been set by the user
if node['visualstudio']['source'].nil?
  raise "'visualstudio source attribute must be set before running this cookbook"
end

edition = node['visualstudio']['edition']
install_url = File.join(node['visualstudio']['source'], node['visualstudio'][edition]['filename'])
checksum = node['visualstudio'][edition]['checksum']
vs_package_name = node['visualstudio'][edition]['package_name']

install_dir = node['visualstudio']['install_dir']
install_log_file = win_friendly_path(File.join(install_dir, 'vsinstall.log'))

seven_zip_exe = File.join(node['7-zip']['home'], '7z.exe')
iso_extraction_dir = win_friendly_path(File.join(Dir.tmpdir(), 'vs2012'))
setup_exe_path = File.join(iso_extraction_dir, node['visualstudio'][edition]['installer_file'])
admin_deployment_xml_file = win_friendly_path(File.join(iso_extraction_dir, 'AdminDeployment.xml'))
vs_is_installed = File.exists?(File.join(install_dir, '\Common7\IDE\devenv.exe'))

# Download ISO to local file cache, or just use if local path
local_iso_path = cached_file(install_url, checksum)

# Create the extraction tmp dir
directory iso_extraction_dir do
  action :create
  notifies :run, 'execute[extract_vs2012_iso]', :immediately
  not_if { vs_is_installed }
end

# Extract the ISO image to the tmp dir
execute 'extract_vs2012_iso' do
  command "#{seven_zip_exe} x -y -o#{iso_extraction_dir} #{local_iso_path}"
  not_if { vs_is_installed }
end

# Create installation config file
cookbook_file admin_deployment_xml_file do
  source 'AdminDeployment-' + edition + '.xml'
  action :create_if_missing
  not_if { vs_is_installed }
end

# Install Visual Studio
windows_package vs_package_name do
  source setup_exe_path
  installer_type :custom
  options "/Q /norestart /Log \"#{install_log_file}\" /AdminFile \"#{admin_deployment_xml_file}\""
  notifies :delete, "directory[#{iso_extraction_dir}]"
  not_if { vs_is_installed }
end

# Cleanup extracted ISO files from tmp dir
directory iso_extraction_dir do
  action :nothing
  recursive true
end
