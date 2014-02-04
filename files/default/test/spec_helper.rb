require 'win32/registry'
require 'minitest/autorun'

module MiniTest::Assertions
  def assert_package_is_installed(package_name)
    assert package_is_installed(package_name), "Expected #{package_name} to be installed"
  end

  def package_is_installed(package_name)
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

String.infect_an_assertion :assert_package_is_installed, :must_be_installed, :only_one_argument
