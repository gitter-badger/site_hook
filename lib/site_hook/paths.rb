##########
# -> File: /home/ken/RubymineProjects/site_hook/lib/site_hook/paths.rb
# -> Project: site_hook
# -> Author: Ken Spencer <me@iotaspencer.me>
# -> Last Modified: 1/10/2018 21:23:00
# -> Copyright (c) 2018 Ken Spencer
# -> License: MIT
##########

module SiteHook
  # Paths: Paths to gem resources and things
  class Paths
    def self.old_config
      Pathname(Dir.home).join('.jph', 'config')
    end
    def self.config
      Pathname(Dir.home).join('.shrc', 'config')
    end

    def self.logs
      Pathname(Dir.home).join('.shrc', 'logs')
    end
    def self.lib_dir
      Pathname(::Gem.user_dir).join('gems', "site_hook-#{SiteHook::VERSION}", 'lib')
    end
  end
end
