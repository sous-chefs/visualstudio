# encoding: UTF-8
describe 'visualstudio::install' do

  describe 'windows' do
    before(:each) do
      ENV['ProgramFiles(x86)'] = 'C:\Program Files (x86)'
      ::File::ALT_SEPARATOR = '\\' # https://github.com/sethvargo/chefspec/issues/371
    end

    let(:chef_run) do
      ChefSpec::Runner.new(platform: 'windows', version: '2008R2') do |node|
        node.set['visualstudio']['source'] = 'http://localhost:8080'
      end.converge(described_recipe)
    end

    it 'tells chef that ppm host name is prefixed with box name' do
      vs_install_dir = chef_run.node['visualstudio']['install_dir']
      expect(vs_install_dir).to eq('C:\Program Files (x86)\Microsoft Visual Studio 11.0')
    end
  end

  describe 'linux' do
    before(:each) do
      ENV['ProgramFiles(x86)'] = nil
      ::File::ALT_SEPARATOR = '/' # COOK-4620
    end

    let(:chef_run) do
      ChefSpec::Runner.new(platform: 'ubuntu', version: '12.04') do |node|
        node.set['visualstudio']['source'] = 'http://localhost:8080'
      end.converge(described_recipe)
    end

    it 'tells chef that ppm host name is prefixed with box name' do
      vs_install_dir = chef_run.node['visualstudio']['install_dir']
      expect(vs_install_dir).to eq('C:\Program Files (x86)\Microsoft Visual Studio 11.0')
    end
  end
end
