Vagrant.configure("2") do |config|
  config.vm.hostname = "visualstudio-berkshelf"
  config.berkshelf.enabled = true
  
  config.windows.halt_timeout = 20
  config.winrm.username = "vagrant"
  config.winrm.password = "vagrant"

  config.vm.box = "windows2008r2"
  
  config.vm.guest = :windows
  config.vm.network :forwarded_port, guest: 5985, host: 5985
  
  config.vm.provider :virtualbox do |vb|
    vb.gui = true
  end
  
  config.vm.provider :vmware_fusion do |v, override|
    v.gui = true
    v.vmx["memsize"] = "2048"
    v.vmx["ethernet0.virtualDev"] = "vmxnet3"
    v.vmx["RemoteDisplay.vnc.enabled"] = "false"
    v.vmx["RemoteDisplay.vnc.port"] = "5900"
  end

  config.vm.provider :vmware_workstation do |v, override|
    v.gui = true
    v.vmx["memsize"] = "2048"
    v.vmx["ethernet0.virtualDev"] = "vmxnet3"
    v.vmx["RemoteDisplay.vnc.enabled"] = "false"
    v.vmx["RemoteDisplay.vnc.port"] = "5900"
  end
  
  # .NET 4.5
  config.vm.provision :chef_solo do |chef|
    chef.log_level = :debug
    chef.file_cache_path = "c:/chef/cache"
    chef.file_backup_path = "c:/chef/backup"
    chef.add_recipe "windows::default"
    chef.add_recipe "windows::reboot_handler"
    chef.add_recipe "minitest-handler::default"
    chef.add_recipe "dotnetframework::default"
    chef.json={
      "dotnetframework"=>{
        "version" => "4.5",
        "4.5"=>{
          "url" => "c:/vagrant/cache/dotnetfx45_full_x86_x64.exe"
        }
      },
      "windows"=>{
        "reboot_timeout" => 15
      }
    }
  end
  
  # SQLCE 4.0 SP1
  config.vm.provision :chef_solo do |chef|
    chef.log_level = :debug
    chef.file_cache_path = "c:/chef/cache"
    chef.file_backup_path = "c:/chef/backup"
    chef.add_recipe "windows::default"
    chef.add_recipe "windows::reboot_handler"
    chef.add_recipe "minitest-handler::default"
    chef.add_recipe "sqlce::default"
    chef.json={
      "windows"=>{
        "reboot_timeout" => 15
      }
    }
  end
  
  # Visual Studio 2012
  config.vm.provision :chef_solo do |chef|
    chef.log_level = :debug
    chef.file_cache_path = "c:/chef/cache"
    chef.file_backup_path = "c:/chef/backup"
    chef.add_recipe "windows::default"
    chef.add_recipe "windows::reboot_handler"
    chef.add_recipe "minitest-handler::default"
    chef.add_recipe "visualstudio::default"
    chef.json={
      "visualstudio"=>{
        "source" => "c:/vagrant/cache",
        "edition" => "ultimate"
      },
      "windows"=>{
        "reboot_timeout" => 15
      }
    }
  end
  
end
