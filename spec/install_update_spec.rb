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
          source: 'http://download.microsoft.com/download/D/4/8/D48D1AC2-A297-4C9E-A9D0-A218E6609F06/VSU4/VS2012.4.exe',
          package_name: 'Visual Studio 2012 Update 4 (KB2707250)',
          checksum: '8c95bd32fe9a4fbd733704bdfb6b6fdaf63f896686156251befef14dc26fe2a0')
    end
  end
end
