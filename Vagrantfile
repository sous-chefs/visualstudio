Vagrant.configure("2") do |config|
  config.vm.box = 'daptiv/windows2012r2_chef12'
  config.vm.communicator = :winrm
  config.vm.provision :chef_solo do |chef|
    chef.add_recipe 'sqlce::default'
    chef.add_recipe 'visualstudio::default'
    chef.add_recipe 'visualstudio::install_update'
    chef.add_recipe 'visualstudio::install_vsto'
    chef.add_recipe 'minitest-handler'
    chef.file_cache_path = 'c:/var/chef/cache' # Need leading drive letter
    chef.json = {
      'visualstudio' => {
        'version' => '2012',
        'edition' => 'professional',
        'source' => 'http://vagrantboxes.hq.daptiv.com/installs/cookbookresources',
        'preserve_extracted_files' => true
      }
    }
  end
end
