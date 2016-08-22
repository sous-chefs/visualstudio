# encoding: UTF-8
#
# Author:: Shawn Neal (<sneal@sneal.net>)
# Cookbook Name:: visualstudio
# Attribute:: vs2013
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
default['visualstudio']['2013']['install_dir'] =
  (ENV['ProgramFiles(x86)'] || 'C:\Program Files (x86)') + '\Microsoft Visual Studio 12.0'

# Community w/Update5
default['visualstudio']['2013']['community']['installer_file'] = 'vs_community.exe'
default['visualstudio']['2013']['community']['filename'] = 'vs2013.5_ce_enu.iso'
default['visualstudio']['2013']['community']['package_name'] =
  'Microsoft Visual Studio Community 2013 with Update 5'
default['visualstudio']['2013']['community']['checksum'] =
  '7de2340d9570895451c5f5d9f2081db860a4f753e7596e31b2742390a6d0e6bc'
default['visualstudio']['2013']['community']['source'] =
  'http://download.microsoft.com/download/A/A/D/AAD1AA11-FF9A-4B3C-8601-054E89260B78'

# Professional w/Update5
default['visualstudio']['2013']['professional']['installer_file'] = 'vs_professional.exe'
default['visualstudio']['2013']['professional']['filename'] = 'vs2013.5_pro_enu.iso'
default['visualstudio']['2013']['professional']['package_name'] =
  'Microsoft Visual Studio Professional 2013'
default['visualstudio']['2013']['professional']['checksum'] =
  '85fdde5e636774c9869bcaab4d2ded83e7a9388014771bf228577eea6112b033'
default['visualstudio']['2013']['professional']['source'] =
  'http://download.microsoft.com/download/F/2/E/F2EFF589-F7D7-478E-B3AB-15F412DA7DEB'

# Test Professional w/Update5
default['visualstudio']['2013']['testprofessional']['installer_file'] = 'vs_testprofessional.exe'
default['visualstudio']['2013']['testprofessional']['filename'] = 'VS2013_RTM_TESTPRO_ENU.iso'
default['visualstudio']['2013']['testprofessional']['package_name'] =
  'Microsoft Visual Studio Test Professional 2013'
default['visualstudio']['2013']['testprofessional']['checksum'] =
  ''
default['visualstudio']['2013']['testprofessional']['source'] =
  'http://download.microsoft.com/download/4/0/6/406E397F-EDBE-4437-B64F-40DF7A92A26E'

# Premium w/Update5
default['visualstudio']['2013']['premium']['installer_file'] = 'vs_premium.exe'
default['visualstudio']['2013']['premium']['filename'] = 'vs2013.5_prem_enu.iso'
default['visualstudio']['2013']['premium']['package_name'] = 'Microsoft Visual Studio Premium 2013'
default['visualstudio']['2013']['premium']['checksum'] =
  ''
default['visualstudio']['2013']['premium']['source'] =
  'http://download.microsoft.com/download/6/5/F/65F510B7-D597-4E80-8EFE-86DDCFCC7C43'

# Ultimate w/Update5
default['visualstudio']['2013']['ultimate']['installer_file'] = 'vs_ultimate.exe'
default['visualstudio']['2013']['ultimate']['filename'] = 'vs2013.5_ult_enu.iso'
default['visualstudio']['2013']['ultimate']['package_name'] =
  'Microsoft Visual Studio Ultimate 2013'
default['visualstudio']['2013']['ultimate']['checksum'] =
  '43a2f252cb3b21cce1149c212f436e9e8190ae73b489f951601a546b62752bef'
default['visualstudio']['2013']['ultimate']['source'] =
  'http://download.microsoft.com/download/E/2/A/E2ADF1BE-8FA0-4436-A260-8780444C8355'

# Update 5
default['visualstudio']['2013']['update']['filename'] = 'VS2013.5.iso'
default['visualstudio']['2013']['update']['checksum'] =
  'baa3e1286bf847ffb1ba6191f14494aa5f0b856ea258284d99924481ea83c6cf'
default['visualstudio']['2013']['update']['package_name'] =
  'Visual Studio 2013 Update 5 (KB3021976)'
default['visualstudio']['2013']['update']['source'] =
  'http://download.microsoft.com/download/A/F/9/AF95E6F8-2E6E-49D0-A48A-8E918D7FD768'
