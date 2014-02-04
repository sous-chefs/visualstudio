require 'minitest/spec'
require_relative 'spec_helper'

class InstallUpdateSpec < MiniTest::Chef::Spec

  describe_recipe 'visualstudio::install_update' do
    describe 'packages' do

      it 'installs VS 2012 SP4' do
        node['visualstudio']['update']['package_name'].must_be_installed
      end

    end
  end

end
