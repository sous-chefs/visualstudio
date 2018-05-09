
describe 'visualstudio::install_vsto' do
  describe 'Visual Studio 2015 Community Edition' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(platform: 'windows', version: '2012R2') do |node|
        node.override['visualstudio']['version'] = '2015'
        node.override['visualstudio']['edition'] = 'community'
      end.converge(described_recipe)
    end
    it 'does not install VSTO' do
      expect(chef_run).not_to install_windows_package(
        'Microsoft Office Developer Tools for Visual Studio 2012 ENU'
      )
    end
  end
  describe 'Visual Studio 2012 Ultimate Edition' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(platform: 'windows', version: '2012R2') do |node|
        node.override['visualstudio']['version'] = '2012'
        node.override['visualstudio']['edition'] = 'ultimate'
      end.converge(described_recipe)
    end
    it 'installs VSTO for VS 2012' do
      pkg_name = 'Microsoft Office Developer Tools for Visual Studio 2012 ENU'
      src_url = 'http://download.microsoft.com/download/2/F/6/' \
        '2F6A4FFA-D409-40C8-AF68-F6F0CBE0A00D/ENU/officetools_bundle.exe'
      options = '/Q /norestart /noweb /Log "C:\Program Files (x86)\\' \
        'Microsoft Visual Studio 11.0\vstoinstall.log"'

      expect(chef_run).to install_windows_package(pkg_name)
        .with(
          source: src_url,
          checksum: '1480da0041446ea534db180acd1ecb7db6cca988242ace536c7eed5c1ae7087e',
          options: options
        )
    end
  end
end
