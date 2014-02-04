#
# Author:: Shawn Neal <sneal@daptiv.com>
# Cookbook Name:: visualstudio
# Recipe:: nuget
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

enable_nuget_package_restore = node['visualstudio']['enable_nuget_package_restore']

# Use setx because the Chef env resource requires a re-login before being available
execute 'set_allow_nuget_to_auto_update' do
  command "setx -m EnableNuGetPackageRestore \"#{enable_nuget_package_restore.to_s}\""
  only_if { ENV['EnableNuGetPackageRestore'] != enable_nuget_package_restore }
end

# Set EnableNuGetPackageRestore for this process
ENV['EnableNuGetPackageRestore'] = enable_nuget_package_restore.to_s
