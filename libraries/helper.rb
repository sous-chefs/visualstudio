module Visualstudio
  module Helper
    def is_vsto_installed?()
      registry_key_exists?(node['visualstudio']['vsto']['package_regkey'])
    end
  end
end
