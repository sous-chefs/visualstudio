name             'visualstudio'
maintainer       'Shawn Neal'
maintainer_email 'sneal@daptiv.com'
license          'Apache 2.0'
description      'Installs/Configures Visual Studio 2012'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version (ENV['BUILD_NUMBER'] ? "0.0.#{ENV['BUILD_NUMBER']}" : '0.1.0')
depends          'windows'
depends          '7-zip'
