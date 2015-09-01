#
# Author:: Ian Kendrick (<iankendrick@gmail.com>)
# Cookbook Name:: visualstudio
# Attribute:: vs2010
#
# Copyright 2015, Ian Kendrick
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
default['visualstudio']['2010']['install_dir'] =
  (ENV['ProgramFiles(x86)'] || 'C:\Program Files (x86)') +
  '\Microsoft Visual Studio 10.0'

# VS 2010 Professional
default['visualstudio']['2010']['professional']['filename'] =
  'en_visual_studio_2010_professional_x86_dvd_509727.iso'
default['visualstudio']['2010']['professional']['package_name'] =
  'Microsoft Visual Studio 2010 Professional - ENU'
default['visualstudio']['2010']['professional']['checksum'] =
  'bdfba5df0bd72cffdb398fe885d9e36d052617647c0ae4fd0579a8fc785c95ba'
default['visualstudio']['2010']['professional']['installer_file'] = File.join('setup', 'setup.exe')
default['visualstudio']['2010']['professional']['config_file'] = 'unattend.ini'

# TODO: Ultimate, Premium

# VS 2010 SP1
default['visualstudio']['2013']['update']['source'] =
  'http://download.microsoft.com/download/A/5/D/A5D85122-E8BB-4C29-8B87-1653058C0DA0/' +
  'VS10SP1-KB2736182.exe'
default['visualstudio']['2013']['update']['checksum'] =
  '8ab60bfb65f49d257d1883bf7aa5464db6c185216009dbab630da6e634dda3ce'
default['visualstudio']['2013']['update']['package_name'] =
  'Microsoft Visual Studio 2010 Service Pack 1'

# VSTO
#http://www.microsoft.com/en-us/download/confirmation.aspx?id=48217
#http://download.microsoft.com/download/7/A/F/7AFA5695-2B52-44AA-9A2D-FC431C231EDC/vstor_redist.exe