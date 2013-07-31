#
# Author:: Shawn Neal <sneal@daptiv.com>
# Cookbook Name:: visualstudio
# Recipe:: default
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

# VS installation requires .NET 4.5 to be installed first
include_recipe 'visualstudio::dotnet_prereq'

# Enable/disable Nuget package restore
include_recipe 'visualstudio::nuget'

# Download the ISO and install, but only if .NET is installed and VS is not installed
dotnet_is_installed = node['visualstudio']['dotnet_is_installed']
install_dir = node['visualstudio']['install_dir']
vs_is_installed = File.exists?(File.join(install_dir, '\Common7\IDE\devenv.exe'))

include_recipe 'visualstudio::install' if dotnet_is_installed && !vs_is_installed
