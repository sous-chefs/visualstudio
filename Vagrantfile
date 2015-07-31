Vagrant.configure("2") do |config|
  config.vm.box_url = 'http://vagrantboxes.hq.daptiv.com/vagrant/boxes/vbox_windows-2008r2_chef-11.12.4.box'
  config.vm.box = 'vbox_windows-2008r2_chef-11.12.4'
  config.vm.communicator = :winrm

  config.vm.provider :virtualbox do |vb|
    vb.gui = true
  end

  config.vm.provider :vmware_fusion do |vb, override|
    vb.gui = true
    override.vm.box = 'vmware_windows-2008r2sp1_chef-11.12.4'
  end

  # Install .NET 4.5 first
#  config.vm.provision :chef_solo do |chef|
#    chef.add_recipe 'dotnetframework'
#    chef.add_recipe 'minitest-handler'
#    chef.add_recipe 'windows::reboot_handler'
#  end
  
 # Now we can finally run the VS recipe
 config.vm.provision :chef_solo do |chef|
   #chef.add_recipe 'sqlce' #avoid bug in SQL CE installer bundled w/VS that forces a reboot
   chef.cookbooks_path = '~/src'
   chef.add_recipe 'visualstudio::default'
   chef.add_recipe 'minitest-handler'
   chef.file_cache_path = 'c:/var/chef/cache' # Need leading drive letter
   chef.json = {
     'visualstudio' => {
       'version' => '2015',
       'edition' => 'professional',
       'source' => 'http://10.3.60.123:8000',
       'preserve_extracted_files' => true
     }
   }
 end
  
end
