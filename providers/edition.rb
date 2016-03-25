# encoding: UTF-8
#
# Author:: Ian Kendrick (<iankendrick@gmail.com>), Shawn Neal (<sneal@sneal.net>)
# Cookbook Name:: visualstudio
# Provider:: edition
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

require 'fileutils'

include Windows::Helper
include Visualstudio::Helper
include Chef::Mixin::PowershellOut

ONE_HOUR_TIMEOUT = 3600

def whyrun_supported?
  true
end

use_inline_resources

action :install do
  unless package_is_installed?(new_resource.package_name)
    converge_by("Installing VisualStudio #{new_resource.edition} #{new_resource.version}") do
      install_vs
    end
    new_resource.updated_by_last_action(true)
  end
end

def install_vs
  with_downloaded_and_mounted_iso do |drive_letter|
    windows_package new_resource.package_name do
      source installer_exe_path(drive_letter)
      installer_type :custom
      options vs_options
      timeout ONE_HOUR_TIMEOUT
      success_codes [0, 127, 3010]
      action :nothing
    end.run_action(:install)
  end
end

def with_downloaded_and_mounted_iso
  with_downloaded_iso do |iso_path|
    with_mounted_iso(iso_path) do |drive_letter|
      yield drive_letter
    end
  end
end

def with_downloaded_iso
  iso_local_path = ::File.join(Chef::Config[:file_cache_path], iso_filename)
  download_iso(iso_local_path)
  begin
    yield iso_local_path
  ensure
    ::File.delete(iso_local_path) if new_resource.delete_iso
  end
end

def download_iso(iso_local_path)
  remote_file "remote_file_#{new_resource.version}_#{new_resource.edition}" do
    source new_resource.source
    checksum new_resource.checksum
    path iso_local_path
    action :nothing
  end.run_action(:create)
end

def with_mounted_iso(iso_local_path)
  drive_letter = mount_iso(iso_local_path)
  begin
    yield drive_letter
  ensure
    powershell_out!("Dismount-DiskImage -ImagePath \"#{iso_local_path}\"")
  end
end

def mount_iso(iso_local_path)
  mount_script = code <<-EOH
    $mountResult = Mount-DiskImage #{iso_local_path} -PassThru
    $mountResult | Get-Volume
    Write-Output ($mountVolume | Get-Volume).DriveLetter
  EOH
  mount_result = powershell_out!(mount_script)
  mount_result.stdout.strip
end

def vs_options
  config_path = create_admin_deployment_file
  setup_options = "/Q /norestart /noweb /log \"#{install_log_file}\" /adminfile \"#{config_path}\""
  if new_resource.product_key
    product_key = new_resource.product_key.delete('-')
    setup_options << " /productkey \"#{product_key}\""
  end
  setup_options
end

def create_admin_deployment_file
  config_source = "#{new_resource.version}/AdminDeployment-#{new_resource.edition}.xml"
  config_path = win_friendly_path(::File.join(Chef::Config[:file_cache_path],
                                              'AdminDeployment.xml'))

  # Create installation config file
  cookbook_file config_path do
    source config_source
    action :nothing
  end.run_action(:create)

  config_path
end

def install_log_file
  win_friendly_path(::File.join(new_resource.install_dir, 'install.log'))
end

def iso_filename
  ::File.basename(new_resource.source)
end

def installer_exe_path(drive_letter)
  installer = new_resource.installer_file || "vs_#{new_resource.edition}.exe"
  ::File.join(drive_letter, installer)
end
