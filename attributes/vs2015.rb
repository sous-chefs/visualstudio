# encoding: UTF-8
#
# Author:: Shawn Neal (<sneal@sneal.net>)
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
  (ENV['ProgramFiles(x86)'] || 'C:\Program Files (x86)') + '\Microsoft Visual Studio 14.0'

# Professional
default['visualstudio']['2015']['professional']['installer_file'] = 'vs_professional.exe'
default['visualstudio']['2015']['professional']['install_url'] =
  'en_visual_studio_professional_2015_x86_x64_dvd_6846629.iso'
default['visualstudio']['2015']['professional']['package_name'] =
  'Microsoft Visual Studio Professional 2015'
default['visualstudio']['2015']['professional']['checksum'] =
  '8d6d9a13ccb7f409161518e07e610c12180f415995fa417fa1343a4f2f4ce74b'

# Community
default['visualstudio']['2015']['community']['installer_file'] = 'vs_community.exe'
default['visualstudio']['2015']['community']['iso_url'] =
  'http://download.microsoft.com/download/5/7/A/57A99666-126E-42FA-8E70-862EDBADD215/' \
  'vs2015.1.com_enu.iso'
default['visualstudio']['2015']['community']['package_name'] =
  'Microsoft Visual Studio Community 2015'
default['visualstudio']['2015']['community']['checksum'] =
  '4bd522a4db378f6d18bfca536510713d29fce48ceb3a2e6bd82cca0e915e1d48'

# Enterprise
default['visualstudio']['2015']['enterprise']['installer_file'] = 'vs_enterprise.exe'
default['visualstudio']['2015']['enterprise']['filename'] =
  'en_visual_studio_enterprise_2015_x86_x64_dvd_6850497.iso'
default['visualstudio']['2015']['enterprise']['package_name'] =
  'Microsoft Visual Studio Enterprise 2015'
default['visualstudio']['2015']['enterprise']['checksum'] =
  '12db74d1e6243924c187069ad95cee58b687dcb9ba2d302fc6ae889fb4ae7694'
