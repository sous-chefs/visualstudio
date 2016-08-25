

require 'minitest/spec'
require_relative 'spec_helper'

# MiniTest to validate VS was installed
class InstallSpec < MiniTest::Chef::Spec
  describe_recipe 'visualstudio::install' do
    describe 'packages' do
      include ChefHelper

      it 'installs VS package' do
        each_version_edition(node) do |version, edition|
          node['visualstudio'][version][edition]['package_name'].must_be_installed
        end
      end

      it 'installs devenv.exe' do
        each_version_edition(node) do |version, _|
          devenv_path = File.join(
            node['visualstudio'][version]['install_dir'],
            '\Common7\IDE\devenv.exe'
          )
          assert File.exist?(devenv_path), "Could not find file #{devenv_path}"
        end
      end
    end
  end
end
