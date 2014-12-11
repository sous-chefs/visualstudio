module Visualstudio
  module Helper

    def is_vs_installed?(install_dir=nil)
      install_dir ||= File.join(node['visualstudio']['install_dir'])
      File.exists?(File.join(install_dir, '\Common7\IDE\devenv.exe'))
    end

    def is_sp_installed?(package_regkey = nil)
      package_regkey ||= node['visualstudio']['update']['package_regkey']
      registry_key_exists?(package_regkey)
    end

    def is_vsto_installed?()
      registry_key_exists?(node['visualstudio']['vsto']['package_regkey'])
    end

    def attribute_from_edition_or_cookbook(edition, value)
      # return either the edition specific, or, failing that, cookbook-wide attribute
      attribute = node['visualstudio'][edition][value] || node['visualstudio'][value]
      raise "attribute #{value} not found for #{edition}" unless attribute
      attribute
    end
  end
end
