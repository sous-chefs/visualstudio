

require 'minitest/spec'
require_relative 'spec_helper'

# MiniTest to validate VS updates were installed
class InstallUpdateSpec < MiniTest::Chef::Spec
  describe_recipe 'visualstudio::install_update' do
    describe 'packages' do
      include ChefHelper
      it 'installs Visual Studio update' do
        each_version_edition(node) do |version, _|
          # not all versions support an update
          if node['visualstudio'][version]['update']
            node['visualstudio'][version]['update']['package_name'].must_be_installed
          end
        end
      end
    end
  end
end
