name             'visualstudio'
maintainer       'Shawn Neal'
maintainer_email 'sneal@sneal.net'
source_url       'https://github.com/windowschefcookbooks/visualstudio'
issues_url       'https://github.com/windowschefcookbooks/visualstudio/issues'
chef_version     '>= 13.0' if respond_to?(:chef_version)
license          'Apache-2.0'
description      'Installs/Configures Visual Studio'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '2.0.0'
supports         'windows'
depends          'windows'
depends          'seven_zip'
