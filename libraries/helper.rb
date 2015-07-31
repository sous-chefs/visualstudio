module Visualstudio
  module Helper

    def is_vs_installed?(version)
      File.exists?(File.join(node['visualstudio'][version]['install_dir'], '\Common7\IDE\devenv.exe'))
    end

    def is_sp_installed?()
      registry_key_exists?(node['visualstudio']['update']['package_regkey'])
    end

    def is_vsto_installed?()
      registry_key_exists?(node['visualstudio']['vsto']['package_regkey'])
    end

  end
end
