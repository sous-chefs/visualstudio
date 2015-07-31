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

visualstudio_update "vs2010update" do
  source node['visualstudio']['source']
  install_dir node['visualstudio']['install_dir']
  installer_file node['visualstudio']['2010']['update']['installer_file']
  filename node['visualstudio']['2010']['update']['filename']
  checksum node['visualstudio']['2010']['update']['checksum']
  package_name node['visualstudio']['2010']['update']['package_name']
  package_regkey node['visualstudio']['2010']['update']['package_regkey']
end
