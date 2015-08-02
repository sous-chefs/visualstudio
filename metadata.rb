name             'visualstudio'
maintainer       'Shawn Neal'
maintainer_email 'sneal@daptiv.com'
license          'Apache 2.0'
description      'Installs/Configures Visual Studio'
ver_path = File.join(File.dirname(__FILE__), 'version.txt')
version ((IO.read(ver_path) if File.exists?(ver_path)) || '0.0.1').chomp
depends          'windows'
depends          'seven_zip'
