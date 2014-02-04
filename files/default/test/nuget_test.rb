require 'minitest/spec'
require_relative 'spec_helper'

class NugetSpec < MiniTest::Chef::Spec

  describe_recipe 'visualstudio::nuget' do
    describe 'configuration' do

      it 'configures the Nuget package restore env var' do
        assert ENV['EnableNuGetPackageRestore'] ==
          node['visualstudio']['enable_nuget_package_restore'].to_s,
            'NuGet package restore was incorrectly configured'
      end

    end
  end

end
