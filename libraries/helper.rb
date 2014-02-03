module Visualstudio
  module Helper

    def is_vs_installed?()
      File.exists?(File.join(node['visualstudio']['install_dir'], '\Common7\IDE\devenv.exe'))
    end

  end
end