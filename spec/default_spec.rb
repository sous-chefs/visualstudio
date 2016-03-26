# encoding: UTF-8
describe 'visualstudio::install' do
  describe 'windows' do
    before(:each) do
      ENV['ProgramFiles(x86)'] = 'C:\Program Files (x86)'
      stub_const('File::ALT_SEPARATOR', '\\')
    end

    let(:chef_run) do
      ChefSpec::SoloRunner.new(platform: 'windows', version: '2008R2') do |node|
      end.converge(described_recipe)
    end

    it 'defaults to VS 2015 Community Edition' do
      expect(chef_run).to install_visualstudio_edition('visualstudio_2015_community')
        .with(
          edition: 'community',
          version: '2015',
          install_dir: 'C:\Program Files (x86)\Microsoft Visual Studio 14.0',
          source: 'http://download.microsoft.com/download/5/7/A/' \
            '57A99666-126E-42FA-8E70-862EDBADD215/vs2015.1.com_enu.iso',
          package_name: 'Microsoft Visual Studio Community 2015',
          checksum: '4bd522a4db378f6d18bfca536510713d29fce48ceb3a2e6bd82cca0e915e1d48',
          preserve_extracted_files: false,
          installer_file: 'vs_community.exe')
    end
  end

  describe 'various installs' do
    before(:each) do
      ENV['ProgramFiles(x86)'] = 'C:\Program Files (x86)'
      stub_const('File::ALT_SEPARATOR', '\\')
    end

    it 'installs VS 2012 TestProfessional when only edition attribute is set' do
      chef_run = ChefSpec::SoloRunner.new(platform: 'windows', version: '2008R2') do |node|
        node.set['visualstudio']['2012']['testprofessional']['iso_url'] =
          'http://localhost:8080/en_visual_studio_test_professional_2012_x86_dvd_920918.iso'
        node.set['visualstudio']['edition'] = 'testprofessional'
      end.converge(described_recipe)
      url = 'http://localhost:8080/en_visual_studio_test_professional_2012_x86_dvd_920918.iso'
      expect(chef_run).to install_visualstudio_edition('visualstudio_2012_testprofessional')
        .with(
          edition: 'testprofessional',
          version: '2012',
          install_dir: 'C:\Program Files (x86)\Microsoft Visual Studio 11.0',
          iso_url: url,
          package_name: 'Microsoft Visual Studio Test Professional 2012',
          checksum: '52075a4d5ab8fa01bf95eb884a62376075b4a38db72add6808c836cc0d01e1f8',
          delete_iso: true,
          installer_file: 'vs_testprofessional.exe')
    end

    it 'installs Vs 2013 Ultimate when edition attribute is set to Ultimate and version to 2013' do
      chef_run = ChefSpec::SoloRunner.new(platform: 'windows', version: '2008R2') do |node|
        node.set['visualstudio']['edition'] = 'ultimate'
        node.set['visualstudio']['version'] = '2013'
      end.converge(described_recipe)
      expect(chef_run).to install_visualstudio_edition('visualstudio_2013_ultimate')
    end

    it 'installs multiple editions and versions when installs attribute is set' do
      chef_run = ChefSpec::SoloRunner.new(platform: 'windows', version: '2008R2') do |node|
        node.set['visualstudio']['installs'] = [
          {
            'edition' => 'testprofessional',
            'version' => '2013'
          },
          {
            'edition' => 'professional',
            'version' => '2015'
          }]
      end.converge(described_recipe)
      expect(chef_run).to install_visualstudio_edition('visualstudio_2013_testprofessional')
      expect(chef_run).to install_visualstudio_edition('visualstudio_2015_professional')
    end
  end

  describe 'linux' do
    before(:each) do
      ENV['ProgramFiles(x86)'] = nil
      stub_const('File::ALT_SEPARATOR', '\\')
    end

    let(:chef_run) do
      ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '12.04') do |node|
      end.converge(described_recipe)
    end

    it 'defaults the install_dir attribute correctly' do
      vs_install_dir = chef_run.node['visualstudio']['2012']['install_dir']
      expect(vs_install_dir).to eq('C:\Program Files (x86)\Microsoft Visual Studio 11.0')
    end
  end
end
