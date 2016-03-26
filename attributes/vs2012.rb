# encoding: UTF-8
#
# Author:: Shawn Neal (<sneal@sneal.net>)
# Cookbook Name:: visualstudio
# Attribute:: vs2012
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

# Currently you cannot change this, doing so will break the cookbook
default['visualstudio']['2012']['install_dir'] =
  (ENV['ProgramFiles(x86)'] || 'C:\Program Files (x86)') + '\Microsoft Visual Studio 11.0'

# Professional
default['visualstudio']['2012']['professional']['installer_file'] = 'vs_professional.exe'
default['visualstudio']['2012']['professional']['filename'] =
  'en_visual_studio_professional_2012_x86_dvd_920779.iso'
default['visualstudio']['2012']['professional']['package_name'] =
  'Microsoft Visual Studio Professional 2012'
default['visualstudio']['2012']['professional']['checksum'] =
  '511f7df6ea22b359f6f0e6a960b6ba8e057e6a177643d6d582a9a289eb2b924b'

# Test Professional
default['visualstudio']['2012']['testprofessional']['installer_file'] = 'vs_testprofessional.exe'
default['visualstudio']['2012']['testprofessional']['filename'] =
  'en_visual_studio_test_professional_2012_x86_dvd_920918.iso'
default['visualstudio']['2012']['testprofessional']['package_name'] =
  'Microsoft Visual Studio Test Professional 2012'
default['visualstudio']['2012']['testprofessional']['checksum'] =
  '52075a4d5ab8fa01bf95eb884a62376075b4a38db72add6808c836cc0d01e1f8'

# Premium
default['visualstudio']['2012']['premium']['installer_file'] = 'vs_premium.exe'
default['visualstudio']['2012']['premium']['filename'] =
  'en_visual_studio_premium_2012_x86_dvd_920758.iso'
default['visualstudio']['2012']['premium']['package_name'] = 'Microsoft Visual Studio Premium 2012'
default['visualstudio']['2012']['premium']['checksum'] =
  '21e5145b05f9af0dff7d5698f37fc7829929c4b13929afe943ff6f6c28ce5492'

# Ultimate
default['visualstudio']['2012']['ultimate']['installer_file'] = 'vs_ultimate.exe'
default['visualstudio']['2012']['ultimate']['filename'] =
  'en_visual_studio_ultimate_2012_x86_dvd_920947.iso'
default['visualstudio']['2012']['ultimate']['package_name'] =
  'Microsoft Visual Studio Ultimate 2012'
default['visualstudio']['2012']['ultimate']['checksum'] =
  'c2c140ec6b16d7d4596b680066de35cbdf60ec049eb42129e5c30945063d2e83'

# Update 5
default['visualstudio']['2012']['update']['filename'] = 'VS2012.5.iso'
default['visualstudio']['2012']['update']['checksum'] =
  '405bad3d4249dd94b4fa309bb482ade9ce63d968b59cac9e2d63b0a24577285e'
default['visualstudio']['2012']['update']['package_name'] =
  'Visual Studio 2012 Update 5 (KB2707250)'
default['visualstudio']['2012']['update']['source'] =
  'https://download.microsoft.com/download/1/7/A/17A8493D-BB25-4811-8242-CCCB74EF982E'

# VS 2012 Office developer tools
default['visualstudio']['2012']['vsto']['installer_file'] = 'officetools_bundle.exe'
default['visualstudio']['2012']['vsto']['package_src_url'] =
  'http://download.microsoft.com/download/2/F/6/2F6A4FFA-D409-40C8-AF68-F6F0CBE0A00D/ENU/' \
  'officetools_bundle.exe'
default['visualstudio']['2012']['vsto']['package_name'] =
  'Microsoft Office Developer Tools for Visual Studio 2012 ENU'
default['visualstudio']['2012']['vsto']['package_regkey'] =
  'HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall' \
  '\11a5e71f-e0d4-46b6-9fba-e5d0fc6149d0}'
default['visualstudio']['2012']['vsto']['checksum'] =
  '1480da0041446ea534db180acd1ecb7db6cca988242ace536c7eed5c1ae7087e'
