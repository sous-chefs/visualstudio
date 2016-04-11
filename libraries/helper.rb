# encoding: UTF-8

module Visualstudio
  # VS cookbook library helper methods
  module Helper
    # Checks if the specified Windows installer package is installed
    def package_is_installed?(package_name)
      if RUBY_PLATFORM =~ /mswin|mingw32|windows/
        windows_package_is_installed?(package_name)
      else
        false
      end
    end

    # Array of VS edition/version hashes to install
    def installs
      return node['visualstudio']['installs'] unless node['visualstudio']['installs'].nil?
      [{
        'edition' => node['visualstudio']['edition'],
        'version' => node['visualstudio']['version']
      }]
    end

    # Array of unique VS versions exclusive of editions
    def versions
      installs.map { |i| i['version'] }.uniq
    end

    # Fails the Chef run if the visualstudio source attribute is not set
    def assert_source_attribute_is_set
      # Ensure the user specified the required source attribute
      if node['visualstudio']['source'].nil?
        fail 'The required attribute node[\'visualstudio\'][\'source\'] is empty, ' \
          'set this and run again!'
      end
    end

    private

    def windows_package_is_installed?(package_name)
      require 'win32/registry'
      Win32::Registry::HKEY_LOCAL_MACHINE.open(uninstall_reg_key) do |uninstall_reg|
        uninstall_reg.each_key do |subkey, _wtime|
          software_reg_key = "#{uninstall_reg_key}\\#{subkey}"
          Win32::Registry::HKEY_LOCAL_MACHINE.open(software_reg_key) do |software_reg|
            return true if package_display_name(software_reg) == package_name
          end
        end
      end
      false
    end

    def uninstall_reg_key
      if node['kernel']['machine'] == 'x86_64'
        'SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall'
      else
        'SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall'
      end
    end

    def package_display_name(software_reg)
      software_reg['DisplayName']
    rescue
      ''
    end
  end
end
