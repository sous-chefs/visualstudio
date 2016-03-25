
#
# Author:: Shawn Neal <sneal@sneal.net>
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

# VS installation requires .NET to be installed first
include_recipe 'visualstudio::dotnet_prereq'

# We require 7-zip in order to extract the ISOs
include_recipe 'seven_zip'

# Enable/disable Nuget package restore
include_recipe 'visualstudio::nuget'

# Install VS
include_recipe 'visualstudio::install'
