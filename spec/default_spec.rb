# encoding: UTF-8
describe 'visualstudio::install' do
  describe 'windows' do
    before(:each) do
      ENV['ProgramFiles(x86)'] = 'C:\Program Files (x86)'
      stub_const('File::ALT_SEPARATOR', '\\')
    end

    let(:chef_run) do
      ChefSpec::SoloRunner.new(platform: 'windows', version: '2008R2') do |node|
        node.set['visualstudio']['source'] = 'http://localhost:8080'
      end.converge(described_recipe)
    end

    it 'defaults the VS 2012 install dir to Microsoft Visual Studio 11.0' do
      vs_install_dir = chef_run.node['visualstudio']['2012']['install_dir']
      expect(vs_install_dir).to eq('C:\Program Files (x86)\Microsoft Visual Studio 11.0')
    end

    it 'defaults to VS 2012 Ultimate' do
      expect(chef_run).to install_visualstudio_edition('visualstudio_2012_ultimate')
        .with(
          edition: 'ultimate',
          version: '2012',
          install_dir: 'C:\Program Files (x86)\Microsoft Visual Studio 11.0',
          source: 'http://localhost:8080/en_visual_studio_ultimate_2012_x86_dvd_920947.iso',
          package_name: 'Microsoft Visual Studio Ultimate 2012',
          checksum: 'c2c140ec6b16d7d4596b680066de35cbdf60ec049eb42129e5c30945063d2e83',
          preserve_extracted_files: false,
          installer_file: 'vs_ultimate.exe')
    end
  end

  describe 'various installs' do
    before(:each) do
      ENV['ProgramFiles(x86)'] = 'C:\Program Files (x86)'
      stub_const('File::ALT_SEPARATOR', '\\')
    end

    it 'raises an error when VS source attribute is not set' do
      chef_run = ChefSpec::SoloRunner.new(platform: 'windows', version: '2008R2')
      expect { chef_run.converge(described_recipe) }.to raise_error(
        RuntimeError,
        'The required attribute node[\'visualstudio\'][\'source\'] is empty, ' \
          'set this and run again!')
    end

    context 'VS 2010' do
      it 'specifies /q for silent installation by default' do
        opts = { platform: 'windows', version: '2008R2', step_into: ['visualstudio_edition'] }
        chef_run = ChefSpec::SoloRunner.new(opts) do |node|
          node.set['visualstudio']['source'] = 'http://localhost:8080'
          node.set['visualstudio']['version'] = '2010'
          node.set['visualstudio']['edition'] = 'professional'
          allow_any_instance_of(Visualstudio::Helper).to receive(:package_is_installed?)
            .and_return(false)
        end.converge(described_recipe)
        expect(chef_run).to install_visualstudio_edition('visualstudio_2010_professional')
          .with(
            edition: 'professional',
            version: '2010',
            configure_basename: nil)
        vs2010_package = chef_run.node['visualstudio']['2010']['professional']['package_name']
        expect(chef_run).to install_windows_package(vs2010_package).with(options: '/q')
      end

      it 'specifies /unattendfile when an unattend.ini file is given' do
        opts = { platform: 'windows', version: '2008R2', step_into: ['visualstudio_edition'] }
        chef_run = ChefSpec::SoloRunner.new(opts) do |node|
          node.set['visualstudio']['source'] = 'http://localhost:8080'
          node.set['visualstudio']['version'] = '2010'
          node.set['visualstudio']['edition'] = 'professional'
          node.set['visualstudio']['2010']['professional']['config_file'] = 'my_unattend.ini'
          allow_any_instance_of(Visualstudio::Helper).to receive(:package_is_installed?)
            .and_return(false)
        end.converge(described_recipe)
        expect(chef_run).to install_visualstudio_edition('visualstudio_2010_professional')
          .with(
            edition: 'professional',
            version: '2010',
            configure_basename: 'my_unattend.ini')
        vs2010_package = chef_run.node['visualstudio']['2010']['professional']['package_name']
        expect(chef_run).to install_windows_package(vs2010_package)
          .with(options: %r{^\/unattendfile ".+my_unattend.ini"$})
      end
    end

    it 'installs VS 2012 TestProfessional when only edition attribute is set' do
      chef_run = ChefSpec::SoloRunner.new(platform: 'windows', version: '2008R2') do |node|
        node.set['visualstudio']['source'] = 'http://localhost:8080'
        node.set['visualstudio']['edition'] = 'testprofessional'
      end.converge(described_recipe)
      url = 'http://localhost:8080/en_visual_studio_test_professional_2012_x86_dvd_920918.iso'
      expect(chef_run).to install_visualstudio_edition('visualstudio_2012_testprofessional')
        .with(
          edition: 'testprofessional',
          version: '2012',
          install_dir: 'C:\Program Files (x86)\Microsoft Visual Studio 11.0',
          source: url,
          package_name: 'Microsoft Visual Studio Test Professional 2012',
          checksum: '52075a4d5ab8fa01bf95eb884a62376075b4a38db72add6808c836cc0d01e1f8',
          preserve_extracted_files: false,
          installer_file: 'vs_testprofessional.exe')
    end

    it 'installs Vs 2013 Ultimate when edition attribute is set to Ultimate and version to 2013' do
      chef_run = ChefSpec::SoloRunner.new(platform: 'windows', version: '2008R2') do |node|
        node.set['visualstudio']['source'] = 'http://localhost:8080'
        node.set['visualstudio']['edition'] = 'ultimate'
        node.set['visualstudio']['version'] = '2013'
      end.converge(described_recipe)
      expect(chef_run).to install_visualstudio_edition('visualstudio_2013_ultimate')
    end

    it 'installs multiple editions and versions when installs attribute is set' do
      chef_run = ChefSpec::SoloRunner.new(platform: 'windows', version: '2008R2') do |node|
        node.set['visualstudio']['source'] = 'http://localhost:8080'
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
        node.set['visualstudio']['source'] = 'http://localhost:8080'
      end.converge(described_recipe)
    end

    it 'defaults the install_dir attribute correctly' do
      vs_install_dir = chef_run.node['visualstudio']['2012']['install_dir']
      expect(vs_install_dir).to eq('C:\Program Files (x86)\Microsoft Visual Studio 11.0')
    end
  end
end
