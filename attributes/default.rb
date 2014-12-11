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

default['visualstudio']['edition'] = 'ultimate' # or premium, professional, testprofessional

# Currently you cannot change this, doing so will break the cookbook
default['visualstudio']['install_dir'] = (ENV['ProgramFiles(x86)'] || 'C:\Program Files (x86)') +
  '\Microsoft Visual Studio 11.0'

# Set this attribute your self to the FQDN of the folder which contains the ISO
# default['visualstudio']['source'] = 'http://example.com:8080/visualstudio'

# VS 2012 Test Professional
default['visualstudio']['testprofessional']['installer_file'] = 'vs_testprofessional.exe'
default['visualstudio']['testprofessional']['filename'] =
  'en_visual_studio_test_professional_2012_x86_dvd_920918.iso'
default['visualstudio']['testprofessional']['package_name'] =
  'Microsoft Visual Studio Test Professional 2012'
default['visualstudio']['testprofessional']['checksum'] =
  '52075a4d5ab8fa01bf95eb884a62376075b4a38db72add6808c836cc0d01e1f8'

# VS 2012 Professional
default['visualstudio']['professional']['installer_file'] = 'vs_professional.exe'
default['visualstudio']['professional']['filename'] =
  'en_visual_studio_professional_2012_x86_dvd_920779.iso'
default['visualstudio']['professional']['package_name'] =
  'Microsoft Visual Studio Professional 2012'
default['visualstudio']['professional']['checksum'] =
  '511f7df6ea22b359f6f0e6a960b6ba8e057e6a177643d6d582a9a289eb2b924b'

# VS 2012 Premium
default['visualstudio']['premium']['installer_file'] = 'vs_premium.exe'
default['visualstudio']['premium']['filename'] = 'en_visual_studio_premium_2012_x86_dvd_920758.iso'
default['visualstudio']['premium']['package_name'] = 'Microsoft Visual Studio Premium 2012'
default['visualstudio']['premium']['checksum'] =
  '21e5145b05f9af0dff7d5698f37fc7829929c4b13929afe943ff6f6c28ce5492'

#VS 2012 Ultimate
default['visualstudio']['ultimate']['installer_file'] = 'vs_ultimate.exe'
default['visualstudio']['ultimate']['filename'] =
  'en_visual_studio_ultimate_2012_x86_dvd_920947.iso'
default['visualstudio']['ultimate']['package_name'] = 'Microsoft Visual Studio Ultimate 2012'
default['visualstudio']['ultimate']['checksum'] =
  'c2c140ec6b16d7d4596b680066de35cbdf60ec049eb42129e5c30945063d2e83'

# VS 2012 Update 4
default['visualstudio']['update']['source'] = node['visualstudio']['source']
default['visualstudio']['update']['filename'] = 'VS2012.4.iso'
default['visualstudio']['update']['installer_file'] = 'VS2012.4.exe'
default['visualstudio']['update']['package_name'] = 'Visual Studio 2012 Update 4 (KB2707250)'
default['visualstudio']['update']['package_regkey'] =
  'HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall' +
  '\{312d9252-c71c-4c84-b171-f4ad46e22098}'
default['visualstudio']['update']['checksum'] =
  'c462118eabcc242a50f1215587cb1c79505159af79fc50c24d8be1d25203cd87'

# VS 2012 Update 4 - Web Updater
default['visualstudio']['update_web']['source'] =
  'http://download.microsoft.com/download/D/4/8/D48D1AC2-A297-4C9E-A9D0-A218E6609F06/VSU4/'
default['visualstudio']['update_web']['checksum'] =
  '8c95bd32fe9a4fbd733704bdfb6b6fdaf63f896686156251befef14dc26fe2a0'

# VS 2012 Office developer tools
default['visualstudio']['vsto']['installer_file'] = 'officetools_bundle.exe'
default['visualstudio']['vsto']['package_src_url'] =
  'http://download.microsoft.com/download/2/F/6/2F6A4FFA-D409-40C8-AF68-F6F0CBE0A00D/ENU/' +
  'officetools_bundle.exe'
default['visualstudio']['vsto']['package_name'] =
  'Microsoft Office Developer Tools for Visual Studio 2012 ENU'
default['visualstudio']['vsto']['package_regkey'] =
  'HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall' +
  '\11a5e71f-e0d4-46b6-9fba-e5d0fc6149d0}'
default['visualstudio']['vsto']['checksum'] =
  '1480da0041446ea534db180acd1ecb7db6cca988242ace536c7eed5c1ae7087e'
#
# VS 2010 Professional
default['visualstudio']['professional_2010']['filename'] =
  'en_visual_studio_2010_professional_x86_dvd_509727.iso'
default['visualstudio']['professional_2010']['package_name'] =
  'Microsoft Visual Studio 2010 Professional - ENU'
default['visualstudio']['professional_2010']['checksum'] =
  'bdfba5df0bd72cffdb398fe885d9e36d052617647c0ae4fd0579a8fc785c95ba'
default['visualstudio']['professional_2010']['install_dir'] =
  (ENV['ProgramFiles(x86)'] || 'C:\Program Files (x86)') + '\Microsoft Visual Studio 10.0'
default['visualstudio']['professional_2010']['installer_file'] = File.join('setup', 'setup.exe')
default['visualstudio']['professional_2010']['config_file'] = 'unattend.ini'

# VS 2010 Update
default['visualstudio']['2010_update']['source'] = node['visualstudio']['source']
default['visualstudio']['2010_update']['filename'] = 'VS2010SP1dvd1.iso'
default['visualstudio']['2010_update']['installer_file'] = 'Setup.exe'
# TODO: determine below
default['visualstudio']['2010_update']['package_name'] =
  'Microsoft Visual Studio 2010 Service Pack 1'
default['visualstudio']['2010_update']['checksum'] =
  'fce24f0e3f95fdeb54b806be3266f3b61a1e6b5b78c7e6c13c36fc1a6f5ba0ad'
default['visualstudio']['2010_update']['package_regkey'] =
  'HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall' +
  '\{ED780CA9-0687-3C12-B439-3369F224941F}'
