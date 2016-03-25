# encoding: UTF-8

name             'visualstudio'
maintainer       'Shawn Neal'
maintainer_email 'sneal@sneal.net'
license          'Apache 2.0'
description      'Installs/Configures Visual Studio'
ver_path = File.join(File.dirname(__FILE__), 'version.txt')
version File.exist?(ver_path) ? IO.read(ver_path).chomp : '1.0.1'
depends          'windows'
depends          'seven_zip'
