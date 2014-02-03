Vagrant.configure("2") do |config|
  config.vm.hostname = "visualstudio-berkshelf"
  config.berkshelf.enabled = true

  config.vm.box_url = 'http://vagrantboxes.hq.daptiv.com/vagrant/boxes/vagrant-windows2008r2.box'
  config.vm.box = 'vagrant-windows2008r2'
  config.vm.guest = :windows
  config.vm.network :forwarded_port, guest: 5985, host: 5985
  
  config.vm.provider :virtualbox do |vb|
    vb.gui = true
  end
  
  # Install .NET 4.5 first
  config.vm.provision :chef_solo do |chef|
    chef.log_level = :info
    chef.add_recipe 'dotnetframework'
    chef.add_recipe 'minitest-handler'
    chef.add_recipe 'windows::reboot_handler'
  end
  
  # Now we can finally run the VS recipe
  config.vm.provision :chef_solo do |chef|
    chef.log_level = :info
    chef.add_recipe 'visualstudio'
    chef.add_recipe 'minitest-handler'
    chef.attempts = 4
    chef.json = {
      'visualstudio' => {
        'edition' => 'professional',
        'source' => 'http://vagrantboxes.hq.daptiv.com/installs/cookbookresources'
      }
    }
  end
  
end
