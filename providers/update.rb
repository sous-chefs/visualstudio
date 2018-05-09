
#
# Author:: Ian Kendrick (<iankendrick@gmail.com>), Shawn Neal (<sneal@sneal.net>)
# Cookbook Name:: visualstudio
# Provider:: update
#
# Copyright 2015, Ian Kendrick, Shawn Neal
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

require 'digest/md5'
require 'mixlib/shellout'

include Windows::Helper
include Visualstudio::Helper

def whyrun_supported?
  true
end

action :install do
  unless package_is_installed?(new_resource.package_name)
    converge_by("Installing #{new_resource.package_name}") do
      # Extract the ISO image to the temporary Chef cache dir
      seven_zip_archive "extract_#{setup_basename}_iso" do
        path extracted_iso_dir
        source new_resource.source
        overwrite true
        checksum new_resource.checksum
      end

      # Install Visual Studio Update
      windows_package new_resource.package_name do
        source setup_exe
        installer_type :custom
        options "/Q /norestart /noweb /Log \"#{install_log_file}\""
        timeout 3600 # 1 hour
        returns [0, 127, 3010]
      end

      # Cleanup extracted ISO files
      directory "remove_#{new_resource.package_name}" do
        path extracted_iso_dir
        action :delete
        recursive true
        not_if { new_resource.preserve_extracted_files }
      end
    end
  end
end

def extracted_iso_dir
  default_path = ::File.join(
    Chef::Config[:file_cache_path],
    Digest::MD5.hexdigest(new_resource.package_name)
  )
  extract_dir = node['visualstudio']['unpack_dir'].nil? ? default_path : node['visualstudio']['unpack_dir']
  win_friendly_path(extract_dir)
end

def install_log_file
  win_friendly_path(::File.join(new_resource.install_dir, 'vsinstallupdate.log'))
end

# only base file name of source, e.g. VS2013.5
def setup_basename
  ::File.basename(new_resource.source, '.iso')
end

# setup executable path, by convention the exe has the same name as the iso
# except VS 2010 which just uses setup.exe
def setup_exe
  setup_file = new_resource.package_name.include?('2010') ? 'setup.exe' : "#{setup_basename}.exe"
  ::File.join(extracted_iso_dir, setup_file)
end
