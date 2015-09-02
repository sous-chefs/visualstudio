module Visualstudio
  module Helper
    def package_is_installed?(package_name)
      require 'win32/registry'
      
      uninstall_reg_key = 'SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall'

      Win32::Registry::HKEY_LOCAL_MACHINE.open(uninstall_reg_key) do |uninstall_reg|
        uninstall_reg.each_key do |subkey, wtime|
          software_reg_key = "#{uninstall_reg_key}\\#{subkey}"
          Win32::Registry::HKEY_LOCAL_MACHINE.open(software_reg_key) do |software_reg|
            begin
              display_name = software_reg['DisplayName']
            rescue
              display_name = ''
            end
            if display_name == package_name
              return true
            end
          end
        end
      end

      # if we make it this far we didn't find the package
      return false
    end

    # array of VS edition/version hashes to install
    def installs
      return node['visualstudio']['installs'] unless node['visualstudio']['installs'].nil?
      return [{
        'edition' => node['visualstudio']['edition'],
        'version' => node['visualstudio']['version']
      }]
    end

    # array of unique VS versions exclusive of editions
    def versions
      installs.map { |i| i['version'] }.uniq
    end

    def assert_source_attribute_is_set
      # Ensure the user specified the required source attribute
      if node['visualstudio']['source'].nil?
        fail 'The required attribute node[\'visualstudio\'][\'source\'] is empty, ' +
          'set this and run again!'
      end
    end
  end
end
