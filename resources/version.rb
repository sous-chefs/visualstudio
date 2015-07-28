actions :create

attribute :edition, kind_of: String, name_attribute: true
attribute :install_dir, kind_of: String, name_attribute: false
attribute :source, kind_of: String, name_attribute: false
attribute :installer_file, kind_of: String
attribute :filename, kind_of: String
attribute :configure_basename, kind_of: String, default: nil
attribute :checksum, kind_of: String
attribute :package_name, kind_of: String
