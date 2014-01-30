#
# Author:: Juan Laube
# Cookbook Name:: visualstudio
# Recipe:: install_sp4
#
# Copyright 2014, Daptiv Solutions, LLC.
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

# Ensure the installation ISO url has been set by the user
package_src_url = node['visualstudio']['sp4']['package_src_url']
temp_dir = win_friendly_path(File.join(Dir.tmpdir(), 'vs2012_sp4'))
setup_exe_path = File.join(temp_dir, node['visualstudio']['sp4']['installer_file'])

# Create install paths
package_name = node['visualstudio']['sp4']['package_name']
install_dir = node['visualstudio']['install_dir']
install_log_file = win_friendly_path(File.join(install_dir, 'sp4install.log'))
vs_is_installed = File.exists?(File.join(install_dir, '\Common7\IDE\devenv.exe'))

# Create temp directory for package installer
directory temp_dir do
  action :create
  not_if { vs_is_installed }
end

# Transfer package installer from Microsoft download site to local filesystem
remote_file setup_exe_path do
  source package_src_url
end

# Install Visual Studio 2012 Update
windows_package package_name do
  source setup_exe_path
  installer_type :custom
  options "/Q /norestart /Log \"#{install_log_file}\""
  action :install
end

# Cleanup temp directory
directory iso_extraction_dir do
  action :nothing
  recursive true
end
