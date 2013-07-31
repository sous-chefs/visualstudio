#
# Author:: Shawn Neal (<sneal@daptiv.com>)
# Cookbook Name:: visualstudio
# Attribute:: default
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

default['visualstudio']['enable_nuget_package_restore'] = true
default['visualstudio']['installer_file'] = 'vs_professional.exe'
default['visualstudio']['package_name'] = 'Microsoft Visual Studio Professional 2012'
default['visualstudio']['checksum'] =
  '511f7df6ea22b359f6f0e6a960b6ba8e057e6a177643d6d582a9a289eb2b924b'

# Currently you cannot change this, doing so will break the cookbook
default['visualstudio']['install_dir'] = 'C:\\Program Files\\Microsoft Visual Studio 11.0'
