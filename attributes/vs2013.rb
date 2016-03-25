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

# Test Professional
default['visualstudio']['2013']['testprofessional']['installer_file'] = 'vs_testprofessional.exe'
default['visualstudio']['2013']['testprofessional']['filename'] = 'VS2013_RTM_TESTPRO_ENU.iso'
default['visualstudio']['2013']['testprofessional']['package_name'] =
  'Microsoft Visual Studio Test Professional 2013'
default['visualstudio']['2013']['testprofessional']['checksum'] =
  'b4930bb83454a2fcbc762da79a4227e92fdbef7d0b395c619829a36c3fb4ec78'

# Professional
default['visualstudio']['2013']['professional']['installer_file'] = 'vs_professional.exe'
default['visualstudio']['2013']['professional']['filename'] =
  'en_visual_studio_professional_2013_x86_dvd_3175298.iso'
default['visualstudio']['2013']['professional']['package_name'] =
  'Microsoft Visual Studio Professional 2013'
default['visualstudio']['2013']['professional']['checksum'] =
  '3bf357ca41b3c8ee04dcb7eb4151674448627c8c649e817bc225a75172845d60'

# Premium
default['visualstudio']['2013']['premium']['installer_file'] = 'vs_premium.exe'
default['visualstudio']['2013']['premium']['filename'] = 'vs2013.4_prem_enu.iso'
default['visualstudio']['2013']['premium']['package_name'] = 'Microsoft Visual Studio Premium 2013'
default['visualstudio']['2013']['premium']['checksum'] =
  '0e08d3eb682545b42b322dff3a5d97ed8d19ade87aa340d6a2064a24f78a2c01'

# Ultimate
default['visualstudio']['2013']['ultimate']['installer_file'] = 'vs_ultimate.exe'
default['visualstudio']['2013']['ultimate']['filename'] = 'vs2013.4_ult_enu.iso'
default['visualstudio']['2013']['ultimate']['package_name'] =
  'Microsoft Visual Studio Ultimate 2013'
default['visualstudio']['2013']['ultimate']['checksum'] =
  '61eefab736579fa8c58a524338a0dc46d15c1bbaf978b660ab93bedb8847756c'

# Update 5
# http://download.microsoft.com/download/A/F/9/AF95E6F8-2E6E-49D0-A48A-8E918D7FD768/VS2013.5.iso
default['visualstudio']['2013']['update']['filename'] = 'VS2013.5.iso'
default['visualstudio']['2013']['update']['source'] = node['visualstudio']['source']
default['visualstudio']['2013']['update']['checksum'] =
  'baa3e1286bf847ffb1ba6191f14494aa5f0b856ea258284d99924481ea83c6cf'
default['visualstudio']['2013']['update']['package_name'] =
  'Visual Studio 2013 Update 5 (KB3021976)'

# Community
default['visualstudio']['2013']['community']['installer_file'] = 'vs_community.exe'
default['visualstudio']['2013']['community']['filename'] = 'vs2013.5_ce_enu.iso'
default['visualstudio']['2013']['community']['package_name'] =
  'Microsoft Visual Studio Community 2013 with Update 5'
default['visualstudio']['2013']['community']['checksum'] =
  '7de2340d9570895451c5f5d9f2081db860a4f753e7596e31b2742390a6d0e6bc'
