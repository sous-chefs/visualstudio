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
install_url = node['visualstudio']['url']
raise "'visualstudio url attribute must be set before running this cookbook" if install_url.nil?

# Create install paths
checksum = node['visualstudio']['checksum']
package_name = node['visualstudio']['package_name']
install_dir = node['visualstudio']['install_dir']
install_log_file = win_friendly_path(File.join(install_dir, 'vsinstall.log'))

iso_extraction_dir = win_friendly_path(File.join(Dir.tmpdir(), 'vs2012'))
setup_exe_path = File.join(iso_extraction_dir, node['visualstudio']['installer_file'])
admin_deployment_xml_file = win_friendly_path(File.join(iso_extraction_dir, 'AdminDeployment.xml'))
seven_zip_exe_path = "#{node['7-zip']['home']}/7z.exe"

# Download ISO to local file cache, or just use if local path
local_iso_path = cached_file(install_url, checksum)

# Create the extraction tmp dir
directory iso_extraction_dir do
  action :create
end

# Extract the ISO image to the tmp dir
execute 'extract_vs2012_iso' do
  command "#{seven_zip_exe_path} x -y -o#{iso_extraction_dir} #{local_iso_path}"
  only_if { true }
end

# Create installation config file
cookbook_file admin_deployment_xml_file

# Install Visual Studio
windows_package package_name do
  source setup_exe_path
  installer_type :custom
  options "/Q /norestart /Log \"#{install_log_file}\" /AdminFile \"#{admin_deployment_xml_file}\""
  action :install
end

# Cleanup extracted ISO files from tmp dir
directory iso_extraction_dir do
  action :delete
  recursive true
end
