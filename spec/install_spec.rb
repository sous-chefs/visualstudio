
describe 'visualstudio::install' do
  describe 'Windows 2008R2' do
    describe 'Visual Studio 2015 Professional' do
      let(:chef_run) do
        ChefSpec::SoloRunner.new(platform: 'windows', version: '2008R2') do |node|
          node.override['visualstudio']['edition'] = 'professional'
        end.converge(described_recipe)
      end
      it 'installs Visual Studio 2015 Professional when only edition attribute is set' do
        url = 'http://download.microsoft.com/download/3/6/A/36A72A3F-711B-4738-B4C6-C668A508D2EE/vs2015.1.pro_enu.iso'
        expect(chef_run).to install_visualstudio_edition('visualstudio_2015_professional')
          .with(
            edition: 'professional',
            version: '2015',
            install_dir: 'C:\Program Files (x86)\Microsoft Visual Studio 14.0',
            source: url,
            package_name: 'Microsoft Visual Studio Professional 2015',
            preserve_extracted_files: false,
            installer_file: 'vs_professional.exe'
          )
      end
      it 'uses the node[visualstudio][source] attribute when set' do
        chef_run = ChefSpec::SoloRunner.new(platform: 'windows', version: '2008R2') do |node|
          node.override['visualstudio']['source'] = 'http://localhost:8000'
          node.override['visualstudio']['version'] = '2015'
          node.override['visualstudio']['edition'] = 'professional'
        end.converge(described_recipe)
        expect(chef_run).to install_visualstudio_edition('visualstudio_2015_professional')
          .with(source: 'http://localhost:8000/vs2015.1.pro_enu.iso')
      end
    end

    describe 'Visual Studio 2012 Ultimate' do
      let(:chef_run) do
        ChefSpec::SoloRunner.new(platform: 'windows', version: '2008R2') do |node|
          node.default['visualstudio']['source'] = 'http://localhost:8080'
          node.override['visualstudio']['version'] = '2012'
          node.override['visualstudio']['edition'] = 'ultimate'
        end.converge(described_recipe)
      end
      it 'defaults the Visual Studio 2012 install dir to Microsoft Visual Studio 11.0' do
        vs_install_dir = chef_run.node['visualstudio']['2012']['install_dir']
        expect(vs_install_dir).to eq('C:\Program Files (x86)\Microsoft Visual Studio 11.0')
      end
      it 'installs Visual Studio 2012 Ultimate' do
        expect(chef_run).to install_visualstudio_edition('visualstudio_2012_ultimate')
          .with(
            edition: 'ultimate',
            version: '2012',
            install_dir: 'C:\Program Files (x86)\Microsoft Visual Studio 11.0',
            source: 'http://localhost:8080/en_visual_studio_ultimate_2012_x86_dvd_920947.iso',
            package_name: 'Microsoft Visual Studio Ultimate 2012',
            checksum: 'c2c140ec6b16d7d4596b680066de35cbdf60ec049eb42129e5c30945063d2e83',
            preserve_extracted_files: false,
            installer_file: 'vs_ultimate.exe'
          )
      end
      it 'raises an error when source is not set' do
        chef_run = ChefSpec::SoloRunner.new(platform: 'windows', version: '2008R2') do |node|
          node.override['visualstudio']['version'] = '2012'
          node.override['visualstudio']['edition'] = 'ultimate'
        end
        expect { chef_run.converge(described_recipe) }.to raise_error(
          RuntimeError,
          'The ISO download source is empty! '\
          'Set the node[\'visualstudio\'][\'2012\'][\'ultimate\'][\'source\'] ' \
          'or node[\'visualstudio\'][\'source\'] attribute and run again!'
        )
      end
    end

    describe 'Visual Studio 2010' do
      it 'specifies /q for silent installation by default' do
        opts = { platform: 'windows', version: '2008R2', step_into: ['visualstudio_edition'] }
        chef_run = ChefSpec::SoloRunner.new(opts) do |node|
          node.default['visualstudio']['source'] = 'http://localhost:8080'
          node.override['visualstudio']['version'] = '2010'
          node.override['visualstudio']['edition'] = 'professional'
        end.converge(described_recipe) do
          allow_any_instance_of(Visualstudio::Helper).to receive(:package_is_installed?)
            .and_return(false)
        end
        expect(chef_run).to install_visualstudio_edition('visualstudio_2010_professional')
          .with(
            edition: 'professional',
            version: '2010',
            configure_basename: nil
          )
        vs2010_package = chef_run.node['visualstudio']['2010']['professional']['package_name']
        expect(chef_run).to install_windows_package(vs2010_package).with(options: '/q')
      end
      it 'specifies /unattendfile when an unattend.ini file is given' do
        opts = { platform: 'windows', version: '2008R2', step_into: ['visualstudio_edition'] }
        chef_run = ChefSpec::SoloRunner.new(opts) do |node|
          node.default['visualstudio']['source'] = 'http://localhost:8080'
          node.override['visualstudio']['version'] = '2010'
          node.override['visualstudio']['edition'] = 'professional'
          node.override['visualstudio']['2010']['professional']['config_file'] = 'my_unattend.ini'
        end.converge(described_recipe) do
          allow_any_instance_of(Visualstudio::Helper).to receive(:package_is_installed?)
            .and_return(false)
        end
        expect(chef_run).to install_visualstudio_edition('visualstudio_2010_professional')
          .with(
            edition: 'professional',
            version: '2010',
            configure_basename: 'my_unattend.ini'
          )
        vs2010_package = chef_run.node['visualstudio']['2010']['professional']['package_name']
        expect(chef_run).to install_windows_package(vs2010_package)
          .with(options: %r{^\/unattendfile ".+my_unattend.ini"$})
      end
    end

    describe 'Visual Studio 2013 Ultimate' do
      let(:chef_run) do
        ChefSpec::SoloRunner.new(platform: 'windows', version: '2008R2') do |node|
          node.default['visualstudio']['source'] = 'http://localhost:8080'
          node.override['visualstudio']['edition'] = 'ultimate'
          node.override['visualstudio']['version'] = '2013'
        end.converge(described_recipe)
      end
      it 'installs Visual Studio 2013 Ultimate when edition and version attribute are set' do
        expect(chef_run).to install_visualstudio_edition('visualstudio_2013_ultimate')
      end
    end

    describe 'Visual Studio 2013 Test Professional and Visual Studio 2015 Professional' do
      let(:chef_run) do
        ChefSpec::SoloRunner.new(platform: 'windows', version: '2008R2') do |node|
          node.default['visualstudio']['source'] = 'http://localhost:8080'
          node.override['visualstudio']['installs'] = [
            {
              'edition' => 'testprofessional',
              'version' => '2013',
            },
            {
              'edition' => 'professional',
              'version' => '2015',
            },
          ]
        end.converge(described_recipe)
      end
      it 'installs multiple editions and versions when installs attribute is set' do
        expect(chef_run).to install_visualstudio_edition('visualstudio_2013_testprofessional')
        expect(chef_run).to install_visualstudio_edition('visualstudio_2015_professional')
      end
    end

    let(:config_xml_path) { 'c:\var\chef\cache\2015\professional\AdminDeployment.xml' }
    it 'customizes the AdminDeployment.xml when install_items set on the node' do
      opts = {
        step_into: ['visualstudio_edition'],
        file_cache_path: 'c:/var/chef/cache',
        platform: 'windows',
        version: '2008R2',
      }
      chef_run = ChefSpec::SoloRunner.new(opts) do |node|
        node.default['visualstudio']['source'] = 'http://localhost:8080'
        node.override['visualstudio']['edition'] = 'professional'
        node.override['visualstudio']['version'] = '2015'
        node.override['visualstudio']['install_items']['NativeLanguageSupport_VCV1']['selected'] = true
      end.converge('visualstudio::install')
      expect(chef_run).to render_file(config_xml_path)
    end
  end

  describe 'Ubuntu 12.04' do
    before(:each) do
      ENV['ProgramFiles(x86)'] = nil
      stub_const('File::ALT_SEPARATOR', '\\')
    end
    let(:chef_run) do
      ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '12.04') do |node|
        node.default['visualstudio']['source'] = 'http://localhost:8080'
      end.converge(described_recipe)
    end
    it 'defaults the install_dir attribute correctly' do
      vs_install_dir = chef_run.node['visualstudio']['2015']['install_dir']
      expect(vs_install_dir).to eq('C:\Program Files (x86)\Microsoft Visual Studio 14.0')
    end
  end
end
