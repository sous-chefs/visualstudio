
#
# Author:: Ian Kendrick (<iankendrick@gmail.com>), Shawn Neal (<sneal@sneal.net>)
# Cookbook:: visualstudio
# Resource:: update
#
# Copyright:: 2015, Ian Kendrick, Shawn Neal
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

actions :install
default_action :install
unified_mode true

# The VS installation directory
attribute :install_dir, kind_of: String, required: true

# The update exe full source URL
attribute :source, kind_of: String, required: true

# The installed MSI package name
attribute :package_name, kind_of: String, required: true

# The source update exe SHA256 checksum
attribute :checksum, kind_of: String

# Should the extracted ISO files be preserved after installation?
attribute :preserve_extracted_files, kind_of: [TrueClass, FalseClass], default: false
