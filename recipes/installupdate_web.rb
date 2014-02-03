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

::Chef::Recipe.send(:include, Visualstudio::Helper)

install_log_file = win_friendly_path(
  File.join(node['visualstudio']['install_dir'], 'spinstall.log'))

# Install Visual Studio 2012 Update
windows_package node['visualstudio']['update_web']['package_name'] do
  source node['visualstudio']['update_web']['package_src_url']
  installer_type :custom
  options "/Q /norestart /Log \"#{install_log_file}\""
  action :install
  not_if { is_vs_installed? }
end
