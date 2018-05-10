

require 'minitest/spec'
require_relative 'spec_helper'

# MiniTest to validate VSTO packages were installed
class InstallVstoSpec < MiniTest::Chef::Spec
  describe_recipe 'visualstudio::install_vsto' do
    describe 'packages' do
      include ChefHelper
      it 'installs VSTO' do
        each_version_edition(node) do |version, _|
          # VSTO is only supported for VS 2012 currently
          node['visualstudio'][version]['vsto']['package_name'].must_be_installed if version == '2012'
        end
      end
    end
  end
end
