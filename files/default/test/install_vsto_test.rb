require 'minitest/spec'
require_relative 'spec_helper'

class InstallVstoSpec < MiniTest::Chef::Spec

  describe_recipe 'visualstudio::install_vsto' do
    describe 'packages' do

      it 'installs VSTO' do
        node['visualstudio']['vsto']['package_name'].must_be_installed
      end

    end
  end

end
