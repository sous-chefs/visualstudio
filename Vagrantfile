# encoding: UTF-8

Vagrant.configure('2') do |config|
  config.vm.box = 'testbox'
  config.vm.box_url = ENV['WINDOWS_BOX_URL']
  config.vm.communicator = :winrm
  config.vm.provision :chef_solo do |chef|
    chef.add_recipe 'visualstudio::default'
    chef.add_recipe 'visualstudio::install_update'
    chef.add_recipe 'visualstudio::install_vsto'
    chef.add_recipe 'minitest-handler'
    chef.file_cache_path = 'c:/var/chef/cache' # Need leading drive letter
    chef.json = {
      'visualstudio' => {
        'version' => '2015',
        'edition' => 'professional',
        'source' => ENV['VS_SOURCE_URL'],
        'preserve_extracted_files' => true
      }
    }
  end
end
