#
# Author:: Shawn Neal (<sneal@daptiv.com>)
# Cookbook Name:: visualstudio
# Attribute:: vs2015
#
# Copyright 2015, Shawn Neal
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

# Currently you cannot change this, doing so will break the cookbook
default['visualstudio']['2015']['install_dir'] =
  (ENV['ProgramFiles(x86)'] || 'C:\Program Files (x86)') +
  '\Microsoft Visual Studio 14.0'

# Professional
default['visualstudio']['2015']['professional']['installer_file'] = 'vs_professional.exe'
default['visualstudio']['2015']['professional']['filename'] =
  'en_visual_studio_professional_2015_x86_x64_dvd_6846629.iso'
default['visualstudio']['2015']['professional']['package_name'] =
  'Microsoft Visual Studio Professional 2015'
default['visualstudio']['2015']['professional']['checksum'] =
  '8d6d9a13ccb7f409161518e07e610c12180f415995fa417fa1343a4f2f4ce74b'
