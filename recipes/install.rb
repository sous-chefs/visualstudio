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

# edition may be a an arry, but check for string for 
# backwards compatibility
[*node['visualstudio']['edition']].each do |edition|
  visualstudio_version edition do
    install_dir node['visualstudio'][edition]['install_dir'] ||
      node['visualstudio']['install_dir']
    source node['visualstudio']['source']
    installer_file node['visualstudio'][edition]['installer_file']
    checksum node['visualstudio'][edition]['checksum']
    filename node['visualstudio'][edition]['filename']
    package_name node['visualstudio'][edition]['package_name']
    configure_basename node['visualstudio'][edition]['config_file']
  end
end
