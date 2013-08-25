#
# Author:: Shawn Neal <sneal@daptiv.com>
# Cookbook Name:: visualstudio
# Recipe:: dotnet_prereq
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

# VS requires .NET 4.5 to be installed before installation
node.default['dotnetframework']['version'] = '4.5'
include_recipe 'dotnetframework'

# If .NET 4.5 is not installed first the VS install silently fails forever
dotnet_45_file = File.join(node['dotnetframework']['dir'], 'Microsoft.Activities.Build.dll')
dotnet_is_installed = File.exists?(dotnet_45_file)
Chef::Log.warn '.NET 4.5 missing, please reboot and rerun chef' unless dotnet_is_installed

# Let other recipes know its missing at start of run
node.set['visualstudio']['dotnet_is_installed'] = File.exists?(dotnet_45_file)
