#
# Author:: Shawn Neal
# Cookbook Name:: visualstudio
# Recipe:: install_update
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

# Ensure the user specified the required source attribute
if node['visualstudio']['source'].nil?
  fail 'The required attribute node[\'visualstudio\'][\'source\'] is empty, ' +
    'set this and run again!'
end

# If the user specified an installs array value use it, otherwise fallback
installs = node['visualstudio']['installs']
if installs.nil?
  installs = [{
    'version' => node['visualstudio']['version']
  }]
end

# Create list of unique VS versions that have updates
versions = installs.map { |i| i['version'] }.uniq
versions.reject! { |v| node['visualstudio'][v]['update'].nil? }

# Install updates for each VS version
versions.each do |version|
  iso_src = ::File.join(node['visualstudio']['source'],
    node['visualstudio'][version]['update']['filename'])

  visualstudio_update "visualstudio_#{version}_update" do
    install_dir node['visualstudio'][version]['install_dir']
    source iso_src
    package_name node['visualstudio'][version]['update']['package_name']
    checksum node['visualstudio'][version]['update']['checksum']
    preserve_extracted_files node['visualstudio']['preserve_extracted_files']
  end
end
