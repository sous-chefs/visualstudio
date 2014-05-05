Vagrant.configure("2") do |config|
  config.vm.hostname = "visualstudio-berkshelf"
  config.berkshelf.enabled = true

  config.vm.box_url = 'http://vagrantboxes.hq.daptiv.com/vagrant/boxes/vagrant-windows2008r2.box'
  config.vm.box = 'vagrant-windows2008r2'
  config.vm.guest = :windows
  config.vm.network :forwarded_port, guest: 5985, host: 5985, auto_correct: true
  
  config.vm.provider :virtualbox do |vb|
    vb.gui = true
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
    chef.add_recipe 'visualstudio::default'
    chef.add_recipe 'visualstudio::nuget'
    chef.add_recipe 'visualstudio::install_update'
    #chef.add_recipe 'visualstudio::install_updateweb'
    chef.add_recipe 'visualstudio::install_vsto'
    chef.add_recipe 'minitest-handler'
    chef.json = {
      'visualstudio' => {
        'edition' => 'professional',
        'source' => 'http://vagrantboxes.hq.daptiv.com/installs/cookbookresources'
      }
    }
  end
  
end
