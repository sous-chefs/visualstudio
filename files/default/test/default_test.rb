require 'minitest/spec'
require_relative 'spec_helper'

class InstallSpec < MiniTest::Chef::Spec

  describe_recipe 'visualstudio::install' do
    describe 'packages' do

      it 'installs VS 2012 package' do
        edition = node['visualstudio']['edition']
        node['visualstudio'][edition]['package_name'].must_be_installed
      end

      it 'installs devenv.exe' do
        devenv_path = File.join(node['visualstudio']['install_dir'], '\Common7\IDE\devenv.exe')
        assert File.exists?(devenv_path), "Could not find file #{devenv_path}"
      end

    end
  end

end
