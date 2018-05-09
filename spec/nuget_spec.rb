describe 'visualstudio::nuget' do
  before(:each) do
    ENV.delete('EnableNuGetPackageRestore')
  end
  describe 'package restore already enabled' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(platform: 'windows', version: '2008R2') do
        ENV['EnableNuGetPackageRestore'] = 'true'
      end.converge(described_recipe)
    end
    it 'is idempotent' do
      expect(chef_run).not_to create_env('EnableNuGetPackageRestore')
    end
  end
  describe 'package restore not yet enabled' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(platform: 'windows', version: '2008R2').converge(described_recipe)
    end
    it 'enables restore' do
      expect(chef_run).to create_env('EnableNuGetPackageRestore').with(value: 'true')
    end
  end
end
