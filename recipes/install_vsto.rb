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
raise "'visualstudio source attribute must be set to run this cookbook" if install_source.nil?

install_filename = node['visualstudio']['vsto']['filename']
install_url = win_friendly_path(File.join (install_source, install_filename))

# Create install paths
package_name = node['visualstudio']['vsto']['package_name']
install_dir = node['visualstudio']['install_dir']
install_log_file = win_friendly_path(File.join(install_dir, 'vstoinstall.log'))

setup_exe_path = File.join(iso_extraction_dir, node['visualstudio']['update']['installer_file'])

# Install Visual Studio 2012 Update
windows_package package_name do
  source setup_exe_path
  installer_type :custom
  options "/Q /norestart /noweb /Log \"#{install_log_file}\""
  action :install
end
