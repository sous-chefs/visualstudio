
#
# Author:: Shawn Neal <sneal@sneal.net>
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
# This recipe ensures .NET 4.5 is installed, if not a warn is logged

dotnet4dir = File.join(ENV['WINDIR'], 'Microsoft.Net\\Framework64\\v4.0.30319')
dotnet_45_file = File.join(dotnet4dir, 'Microsoft.Activities.Build.dll')
dotnet_is_not_installed_msg = '.NET 4.5 must be installed before installing VisualStudio. ' \
  'This is required otherwise the Visual Studio installer will silently fail. ' \
  'Please install .NET 4.5, reboot, then run this recipe again.'
Chef::Log.warn dotnet_is_not_installed_msg unless File.exist?(dotnet_45_file)
