include Windows::Helper
action :create do
  if vs_installed?(new_resource.install_dir)
  else
    edition = new_resource.edition
    install_url = ::File.join(new_resource.source,
      new_resource.filename)
    install_log_file = win_friendly_path(::File.join(new_resource.install_dir,
      'vsinstall.log'))
    extracted_iso = win_friendly_path(::File.join(
      Chef::Config[:file_cache_path], 'vs2012', edition))
    setup_exe_path = ::File.join(extracted_iso, new_resource.installer_file)

    # Extract the ISO image to the tmp dir
    seven_zip_archive "extract #{edition} iso" do
      path extracted_iso
      source install_url
      overwrite true
      checksum new_resource.checksum
    end

    ini_install = !new_resource.configure_basename.nil?
    if ini_install
      config_source = new_resource.configure_basename
      config_path = win_friendly_path(::File.join(
        extracted_iso, new_resource.configure_basename))
      template "#{config_path}.tmp" do
        source "#{config_source}.erb"
        action :create
        variables 'chef_cache_path' => Chef::Config[:file_cache_path].downcase
      end

      # chef creates utf-8 ini file but VS expects unicode
      # use powershell to update
      powershell_script 'convert unattend.ini to unicode' do
        code(
          "gc -en utf8 #{config_path}.tmp | Out-File -en unicode #{config_path}"
        )
      end
      setup_options = " /unattendfile \"#{config_path}\""
    else
      config_source = "AdminDeployment-#{new_resource.edition}.xml"
      config_path = win_friendly_path(::File.join(
        extracted_iso, 'AdminDeployment.xml'))
      # Create installation config file
      cookbook_file config_path do
        source config_source
        action :create
      end
      setup_options = " /AdminFile \"#{config_path}\""
    end

    # Install Visual Studio
    windows_package new_resource.package_name do
      source setup_exe_path
      installer_type :custom
      options(
        "/Q /norestart /Log \"#{install_log_file}\" #{setup_options}")
      notifies :delete, "directory[#{extracted_iso}]"
      timeout 3600 # 1hour
    end

    # Cleanup extracted ISO files from tmp dir
    directory extracted_iso do
      action :nothing
      recursive true
      not_if { node['visualstudio']['preserve_extracted_files'] }
    end
    new_resource.updated_by_last_action(true)
  end
end
def vs_installed?(install_dir = nil)
  install_dir ||= ::File.join(node['visualstudio']['install_dir'])
  ::File.exist?(::File.join(install_dir, '\Common7\IDE\devenv.exe'))
end
