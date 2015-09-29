require 'minitest/spec'
require_relative 'spec_helper'

class InstallUpdateSpec < MiniTest::Chef::Spec

  describe_recipe 'visualstudio::install_update' do
    describe 'packages' do
      include ChefHelper

      it 'installs Visual Studio update' do
        each_version_edition(node) do |version, _|
          node['visualstudio'][version]['update']['package_name'].must_be_installed
        end
      end
    end
  end
end
