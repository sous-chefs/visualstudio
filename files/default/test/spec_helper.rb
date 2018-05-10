require 'win32/registry'
require 'minitest/autorun'

# MiniTest helper methods
module ChefHelper
  def installs(node)
    return node['visualstudio']['installs'] unless node['visualstudio']['installs'].nil?
    [{
      'edition' => node['visualstudio']['edition'],
      'version' => node['visualstudio']['version'],
    }]
  end

  def each_version_edition(node)
    installs(node).each do |install|
      yield install['version'], install['edition']
    end
  end
end

module MiniTest
  # MiniTest assertions for VS cookbook
  module Assertions
    def assert_package_is_installed(package_name)
      assert package_is_installed?(package_name), "Expected #{package_name} to be installed"
    end

    def package_is_installed?(package_name)
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

String.infect_an_assertion :assert_package_is_installed, :must_be_installed, :only_one_argument
