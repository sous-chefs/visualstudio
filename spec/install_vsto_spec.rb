# encoding: UTF-8
describe 'visualstudio::install_vsto' do
  describe 'windows' do
    before(:each) do
      ENV['ProgramFiles(x86)'] = 'C:\Program Files (x86)'
      stub_const('File::ALT_SEPARATOR', '\\')
    end

    let(:chef_run) do
      ChefSpec::SoloRunner.new(platform: 'windows', version: '2008R2').converge(described_recipe)
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
          options: options)
    end
  end
end
