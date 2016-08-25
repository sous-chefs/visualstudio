
describe 'visualstudio::install_update' do
  describe 'Visual Studio 2015 Community Edition' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(platform: 'windows', version: '2008R2').converge(described_recipe)
    end
    it 'does not install any updates by default' do
      expect(chef_run).not_to install_visualstudio_update('visualstudio_2015_update')
      expect(chef_run).not_to install_visualstudio_update('visualstudio_2013_update')
      expect(chef_run).not_to install_visualstudio_update('visualstudio_2012_update')
      expect(chef_run).not_to install_visualstudio_update('visualstudio_2010_update')
    end
  end

  describe 'Visual Studio 2012 Ultimate Edition' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(platform: 'windows', version: '2008R2') do |node|
        node.override['visualstudio']['version'] = '2012'
        node.override['visualstudio']['edition'] = 'ultimate'
      end.converge(described_recipe)
    end
    it 'installs the VS 2012 update' do
      expect(chef_run).to install_visualstudio_update('visualstudio_2012_update')
        .with(
          install_dir: 'C:\Program Files (x86)\Microsoft Visual Studio 11.0',
          source: 'https://download.microsoft.com/download/1/7/A/17A8493D-BB25-4811-8242-CCCB74EF982E/VS2012.5.iso',
          package_name: 'Visual Studio 2012 Update 5 (KB2707250)',
          checksum: '405bad3d4249dd94b4fa309bb482ade9ce63d968b59cac9e2d63b0a24577285e'
        )
    end
  end
end
