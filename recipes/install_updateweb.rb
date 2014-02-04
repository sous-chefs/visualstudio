#
# Author:: Juan Laube
# Cookbook Name:: visualstudio
# Recipe:: installupdate_web
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

install_log_file = win_friendly_path(
  File.join(node['visualstudio']['install_dir'], 'spinstall.log'))

install_url = File.join(node['visualstudio']['update_web']['source'],
  node['visualstudio']['update']['installer_file'])

# Install Visual Studio 2012 Update
windows_package node['visualstudio']['update']['package_name'] do
  source install_url
  checksum node['visualstudio']['update_web']['checksum']
  installer_type :custom
  options "/Q /norestart /Log \"#{install_log_file}\""
  action :install
end
