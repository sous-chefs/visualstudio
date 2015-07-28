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

visualstudio_update "vs2012update" do
  source node['visualstudio']['update']['source']
  install_dir node['visualstudio']['install_dir']
  installer_file node['visualstudio']['update']['installer_file']
  filename node['visualstudio']['update']['filename']
  checksum node['visualstudio']['update']['checksum']
  package_name node['visualstudio']['update']['package_name']
  package_regkey node['visualstudio']['update']['package_regkey']
end
