# encoding: UTF-8
#
# Author:: Shawn Neal <sneal@sneal.net>
# Cookbook Name:: visualstudio
# Recipe:: install
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

::Chef::Recipe.send(:include, Visualstudio::Helper)

# Install each specified edition/version
installs.each do |install|
  version = install['version']
  edition = install['edition']
  edition_attr = node['visualstudio'][version][edition]
  visualstudio_edition "visualstudio_#{version}_#{edition}" do
    edition edition
    version version
    delete_iso node['visualstudio']['delete_iso']
    install_dir node['visualstudio'][version]['install_dir']
    product_key edition_attr['product_key']
    package_name edition_attr['package_name']
    checksum edition_attr['checksum']
    installer_file edition_attr['installer_file']
    source edition_attr['iso_url']
  end
end
