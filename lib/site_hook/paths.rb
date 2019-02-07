##########
# -> File: /home/ken/RubymineProjects/site_hook/lib/site_hook/paths.rb
# -> Project: site_hook
# -> Author: Ken Spencer <me@iotaspencer.me>
# -> Last Modified: 1/10/2018 21:23:00
# -> Copyright (c) 2018 Ken Spencer
# -> License: MIT
##########
require 'site_hook/methods'
module SiteHook
  # Paths: Paths to gem resources and things
  class Paths
    def self.old_config
      Pathname(Dir.home).join('.jph', 'config')
    rescue Errno::ENOENT => e

    end
    def self.config
      Pathname(Dir.home).join('.shrc', 'config')
    rescue Errno::ENOENT => e

    end

    def self.logs
      Pathname(Dir.home).join('.shrc', 'logs')
    rescue Errno::ENOENT => e

    end
    def self.old_logs
      Pathname(Dir.home).join('.jph', 'logs')
    rescue Errno::ENOENT => e

    end
    def self.lib_dir
      Pathname(::Gem.user_dir).join('gems', "site_hook-#{SiteHook::VERSION}", 'lib')
    rescue Errno::ENOENT => e

    end
    def self.make_log_name(klass, level, old_exists = self.old_logs.exist?)
      case old_exists
      when true
        self.old_logs.join("#{SiteHook::Methods.safe_log_name(self)}-#{@log_level}.log").to_s
      when false
        self.logs.join("#{SiteHook::Methods.safe_log_name(self)}-#{@log_level}.log").to_s
      end
    rescue Errno::ENOENT => e

    end
  end
end
