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

# Ensure 7-zip is installed
include_recipe '7-zip::default'

# Ensure the installation ISO url has been set by the user
install_source = node['visualstudio']['source']
raise "'visualstudio source attribute must be set before running this cookbook" if install_source.nil?
install_filename = node['visualstudio']['update']['filename']
install_url = win_friendly_path(File.join(install_source, install_filename))

# Create install paths
checksum = node['visualstudio']['update']['checksum']
package_name = node['visualstudio']['update']['package_name']
install_dir = node['visualstudio']['install_dir']
install_log_file = win_friendly_path(File.join(install_dir, 'vsupdateinstall.log'))

iso_extraction_dir = win_friendly_path(File.join(Dir.tmpdir(), 'vs2012update'))
setup_exe_path = File.join(iso_extraction_dir, node['visualstudio']['update']['installer_file'])
seven_zip_exe_path = "#{node['7-zip']['home']}/7z.exe"

updatekey = node['visualstudio']['update']['registrykey']

# Download ISO to local file cache, or just use if local path
local_iso_path = cached_file(install_url, checksum)

# Create the extraction tmp dir
directory iso_extraction_dir do
  action :create
end

# Extract the ISO image to the tmp dir
execute 'extract_vs2012_update_iso' do
  command "#{seven_zip_exe_path} x -y -o#{iso_extraction_dir} #{local_iso_path}"
  # TODO: Ensure Idempotence - not_if { registry_key_exists?(updatekey, :i386) }
end

windows_reboot 1 do
  reason 'Visual Studio 2012 Update Install Complete'
  action :nothing
end

# Install Visual Studio 2012 Update
windows_package package_name do
  source setup_exe_path
  installer_type :custom
  options "/Q /norestart /noweb /Log \"#{install_log_file}\""
  action :install
  # notifies :request, 'windows_reboot[1]'
end

# Cleanup extracted ISO files from tmp dir
directory iso_extraction_dir do
  action :delete
  recursive true
end