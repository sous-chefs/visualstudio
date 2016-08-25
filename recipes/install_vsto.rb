
#
# Author:: Juan Laube
# Cookbook Name:: visualstudio
# Recipe:: install_vsto
#
# Copyright 2014, Daptiv Solutions, LLC.
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

::Chef::Recipe.send(:include, Visualstudio::Helper)

# Install VSTO for each VS version
versions.each do |version|
  if version == '2012'
    install_log_path = win_friendly_path(
      File.join(node['visualstudio']['2012']['install_dir'], 'vstoinstall.log')
    )

    # By removing this key we can skip an uncessary reboot before installing VSTO
    key = 'HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion' \
      '\WindowsUpdate\Auto Update\RebootRequired'
    registry_key key do
      recursive true
      action :delete_key
    end

    # Install Visual Studio Tools for Office
    windows_package node['visualstudio']['2012']['vsto']['package_name'] do
      source node['visualstudio']['2012']['vsto']['package_src_url']
      checksum node['visualstudio']['2012']['vsto']['checksum']
      installer_type :custom
      options "/Q /norestart /noweb /Log \"#{install_log_path}\""
      timeout 1800
      action :install
    end
  else
    Chef::Log.warn("VSTO is not currently supported for Visual Studio #{version}")
  end
end
