Vagrant.configure("2") do |config|
  
  config.berkshelf.enabled = true
  
  config.windows.halt_timeout = 20
  config.winrm.username = "vagrant"
  config.winrm.password = "vagrant"

  config.vm.box = "vagrant-windows2008r2"
  config.vm.box_url = "http://vmit07.hq.daptiv.com/vagrant/boxes/vagrant-windows2008r2.box"
  
  config.vm.guest = :windows
  config.vm.network :forwarded_port, guest: 5985, host: 5985
  
  config.vm.provider :virtualbox do |vb|
    vb.gui = true
  end

  config.vm.provision :chef_solo do |chef|
    chef.log_level = :debug
    chef.add_recipe "windows::default"
    chef.add_recipe "windows::reboot_handler"
    chef.add_recipe "minitest-handler::default"
    chef.add_recipe "visualstudio::default"
    chef.json={
      "visualstudio"=>{
        "url" => "http://vmit07.hq.daptiv.com/installs/MicrosoftVisual%20Studio%202012/Visual%20Studio%20Professional%202012%20x86/en_visual_studio_professional_2012_x86_dvd_920779.iso"
      }
    }
  end
  
end
