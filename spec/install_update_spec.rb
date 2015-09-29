# encoding: UTF-8
describe 'visualstudio::install_update' do

  describe 'windows' do
    before(:each) do
      ENV['ProgramFiles(x86)'] = 'C:\Program Files (x86)'
      stub_const('File::ALT_SEPARATOR', '\\')
    end

    let(:chef_run) do
      ChefSpec::Runner.new(platform: 'windows', version: '2008R2') do |node|
        node.set['visualstudio']['source'] = 'http://localhost:8080'
      end.converge(described_recipe)
    end

    it 'defaults to VS 2012 update' do
      expect(chef_run).to install_visualstudio_update('visualstudio_2012_update').
        with(
          install_dir: 'C:\Program Files (x86)\Microsoft Visual Studio 11.0',
          source: 'http://localhost:8080/VS2012.4.iso',
          package_name: 'Visual Studio 2012 Update 4 (KB2707250)',
          checksum: 'c462118eabcc242a50f1215587cb1c79505159af79fc50c24d8be1d25203cd87')
    end
  end
end
