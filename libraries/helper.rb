module Visualstudio
  module Helper
    def is_vsto_installed?()
      version = node['visualstudio']['version']
      registry_key_exists?(node['visualstudio'][version]['vsto']['package_regkey'])
    end

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
  end
end
