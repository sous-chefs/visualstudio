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

# Community w/Update1
default['visualstudio']['2015']['community']['installer_file'] = 'vs_community.exe'
default['visualstudio']['2015']['community']['filename'] =
  'vs2015.1.com_enu.iso'
default['visualstudio']['2015']['community']['package_name'] =
  'Microsoft Visual Studio Community 2015'
default['visualstudio']['2015']['community']['checksum'] =
  '4bd522a4db378f6d18bfca536510713d29fce48ceb3a2e6bd82cca0e915e1d48'
default['visualstudio']['2015']['community']['source'] =
  'http://download.microsoft.com/download/5/7/A/57A99666-126E-42FA-8E70-862EDBADD215'

# Professional w/Update1
default['visualstudio']['2015']['professional']['installer_file'] = 'vs_professional.exe'
default['visualstudio']['2015']['professional']['filename'] = 'vs2015.1.pro_enu.iso'
default['visualstudio']['2015']['professional']['package_name'] =
  'Microsoft Visual Studio Professional 2015'
default['visualstudio']['2015']['professional']['checksum'] = ''
default['visualstudio']['2015']['professional']['source'] =
  'http://download.microsoft.com/download/3/6/A/36A72A3F-711B-4738-B4C6-C668A508D2EE'

# Test Professional w/Update1
default['visualstudio']['2015']['testprofessional']['installer_file'] = 'vs_testprofessional.exe'
default['visualstudio']['2015']['testprofessional']['filename'] = 'vs2015.testpro_enu.iso'
default['visualstudio']['2015']['testprofessional']['package_name'] =
  'Microsoft Visual Studio Test Professional 2015'
default['visualstudio']['2015']['testprofessional']['checksum'] = ''
default['visualstudio']['2015']['testprofessional']['source'] =
  'http://download.microsoft.com/download/8/5/6/856E021B-39D6-4593-B7BB-2F8D1178EBCB'

# Enterprise w/Update1
default['visualstudio']['2015']['enterprise']['installer_file'] = 'vs_enterprise.exe'
default['visualstudio']['2015']['enterprise']['filename'] = 'vs2015.1.ent_enu.iso'
default['visualstudio']['2015']['enterprise']['package_name'] =
  'Microsoft Visual Studio Enterprise 2015'
default['visualstudio']['2015']['enterprise']['checksum'] = ''
default['visualstudio']['2015']['professional']['source'] =
  'http://download.microsoft.com/download/6/C/9/6C95B548-64A9-4637-A7F2-EB2A750C7504'
