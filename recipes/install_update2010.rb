#
# Author:: Joe Fitzgerald
# Cookbook Name:: visualstudio
# Recipe:: installupdate
#
# Copyright 2013, Joe Fitzgerald.
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

sp_is_installed = is_sp_installed?(node['visualstudio']['2010_update']['package_regkey'])
# Ensure the installation ISO url has been set by the user
source = node['visualstudio']['2010_update']['source'] || node['visualstudio']['source']
raise 'visualstudio update source attribute must be set before running this recipe' unless source

install_url = File.join(source, node['visualstudio']['2010_update']['filename'])

# Create install paths
install_log_file = win_friendly_path(
  File.join(node['visualstudio']['install_dir'], 'vsupdateinstall.log'))
iso_extraction_dir = win_friendly_path(File.join(Chef::Config[:file_cache_path], 'vs2010update'))
setup_exe_path =
  File.join(iso_extraction_dir, node['visualstudio']['2010_update']['installer_file'])

# Extract the ISO image to the tmp dir
seven_zip_archive 'extract_vs2010_sp_iso' do
  path iso_extraction_dir
  source install_url
  overwrite true
  checksum node['visualstudio']['2010_update']['checksum']
  not_if { sp_is_installed }
end

# Install Visual Studio 2012 Update
windows_package 'install_vs2010_sp' do
  package_name node['visualstudio']['2010_update']['package_name']
  source setup_exe_path
  installer_type :custom
  options "/Q /norestart /noweb /Log \"#{install_log_file}\""
  timeout 1800 # 30 minutes
  not_if { sp_is_installed }
  notifies :delete, "directory[#{iso_extraction_dir}]"
end

# Cleanup extracted ISO files from tmp dir
directory iso_extraction_dir do
  action :nothing
  recursive true
  not_if { node['visualstudio']['preserve_extracted_files'] }
end
