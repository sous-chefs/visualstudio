include DSL::RegistryHelper
include Windows::Helper

action :create do
  if registry_key_exists?(new_resource.package_regkey)
  else
    install_url = ::File.join(new_resource.source, new_resource.filename)
    install_log = ::File.join(new_resource.install_dir, 'vsupdateinstall.log')
    extracted_iso_path = win_friendly_path(
      ::File.join(Chef::Config[:file_cache_path],
                  "#{new_resource.edition}_update"))
    setup_exe_path = ::File.join(extracted_iso_path,
                                 new_resource.installer_file)
    seven_zip_archive "extract_#{new_resource.edition}_iso" do
      path extracted_iso_path
      source install_url
      overwrite true
      checksum new_resource.checksum
    end

    # Install Visual Studio 2012 Update
    windows_package new_resource.package_name do
      source setup_exe_path
      installer_type :custom
      options "/Q /norestart /noweb /Log \"#{install_log}\""
      timeout 1800 # 30 minutes
      notifies :delete, "directory[#{extracted_iso_path}]"
    end

    # Cleanup extracted ISO files from tmp dir
    directory extracted_iso_path do
      action :nothing
      recursive true
      not_if { node['visualstudio']['preserve_extracted_files'] }
    end
  end
end
