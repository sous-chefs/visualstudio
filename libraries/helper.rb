module Visualstudio
  module Helper
    def is_vsto_installed?()
      version = node['visualstudio']['version']
      registry_key_exists?(node['visualstudio'][version]['vsto']['package_regkey'])
    end
  end
end
