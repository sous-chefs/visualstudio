Vagrant.configure("2") do |config|
  config.vm.box_url = 'http://vagrantboxes.hq.daptiv.com/vagrant/boxes/virtualbox_windows-2012r2_chef-11.12.4_0.1.0.box'
  config.vm.box = 'virtualbox_windows-2012r2_chef-11.12.4_0.1.0'
  config.vm.communicator = :winrm

  config.vm.provider :virtualbox do |vb|
    vb.gui = false
  end

  # Install .NET 4.5 first
  config.vm.provision :chef_solo do |chef|
    chef.add_recipe 'dotnetframework'
    chef.add_recipe 'windows::reboot_handler'
  end
  
 # Now we can finally run the VS recipe
 config.vm.provision :chef_solo do |chef|
   chef.add_recipe 'visualstudio::default'
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
