Vagrant.configure("2") do |config|
  config.vm.box_url = 'http://vagrantboxes.hq.daptiv.com/vagrant/boxes/vbox_windows-2008r2_chef-11.12.2.box'
  config.vm.box = 'vbox_windows-2008r2_chef-11.12.2'
  config.vm.guest = :windows
  config.vm.network :forwarded_port, guest: 5985, host: 5985, auto_correct: true

  config.vm.provider :virtualbox do |vb|
    vb.gui = true
  end

  config.vm.provider :vmware_fusion do |vb, override|
    vb.gui = true
    override.vm.box = 'vmware_windows-2008r2sp1_chef-11.12.4'
  end

  config.vm.provider :vsphere do |vsphere, override|
    override.vm.box = "vsphere-dummy"
    override.vm.box_url = "http://vagrantboxes.hq.daptiv.com/vagrant/boxes/vsphere-dummy.box"
    vsphere.insecure = true
    vsphere.host = ENV['vpshere_host']
    vsphere.data_center_name = ENV['vpshere_data_center_name']
    vsphere.data_store_name = ENV['vpshere_data_store_name']
    vsphere.compute_resource_name = ENV['vpshere_compute_resource_name']
    vsphere.resource_pool_name = ENV['vpshere_resource_pool_name']
    vsphere.template_name = 'Templates/windows-2008r2_chef-11.10.4'
    vsphere.user = ENV['vsphere_user']
    vsphere.password = ENV['vsphere_password']
  end
  
  # Install .NET 4.5 first
  config.vm.provision :chef_solo do |chef|
    chef.add_recipe 'dotnetframework'
    chef.add_recipe 'minitest-handler'
    chef.add_recipe 'windows::reboot_handler'
  end
  
 # Now we can finally run the VS recipe
 config.vm.provision :chef_solo do |chef|
   chef.add_recipe 'sqlce' #avoid bug in SQL CE installer bundled w/VS that forces a reboot
   chef.add_recipe 'visualstudio::default'
   chef.add_recipe 'visualstudio::nuget'
   chef.add_recipe 'visualstudio::install_update' # or visualstudio::install_updateweb
   chef.add_recipe 'visualstudio::install_vsto'
   chef.add_recipe 'minitest-handler'
   chef.file_cache_path = 'c:/var/chef/cache' # Need leading drive letter
   chef.json = {
     'visualstudio' => {
       'edition' => 'professional',
       'source' => 'http://vagrantboxes.hq.daptiv.com/installs/cookbookresources',
       'preserve_extracted_files' => true
     }
   }
 end
  
end
