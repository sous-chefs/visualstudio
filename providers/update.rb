#
# Author:: Ian Kendrick (<iankendrick@gmail.com>), Shawn Neal (<sneal@daptiv.com>)
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

include Windows::Helper

action :install do
  if !vs_update_installed?
    converge_by("Installing #{new_resource.package_name}") do

      # Install Visual Studio Update
      install_log_file = win_friendly_path(::File.join(
        new_resource.install_dir, 'vsinstall_update.log'))

      windows_package new_resource.package_name do
        source new_resource.source
        checksum new_resource.checksum
        installer_type :custom
        options "/Q /norestart /Log \"#{install_log_file}\""
        timeout 3600 # 1 hour
      end

      # Done, keep further Chef runs from installing
      write_idempotence_check_file
    end
    new_resource.updated_by_last_action(true)
  end
end

def idempotence_check_file
  ::File.join(new_resource.install_dir, 'vsinstall_update.inst')
end

def write_idempotence_check_file
  IO.write(idempotence_check_file, new_resource.package_name)
end

def vs_update_installed?
  ::File.exist?(idempotence_check_file) &&
    (IO.read(idempotence_check_file).chomp == new_resource.package_name)
end
