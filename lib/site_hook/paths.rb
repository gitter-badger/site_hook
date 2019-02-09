##########
# -> File: /home/ken/RubymineProjects/site_hook/lib/site_hook/paths.rb
# -> Project: site_hook
# -> Author: Ken Spencer <me@iotaspencer.me>
# -> Last Modified: 1/10/2018 21:23:00
# -> Copyright (c) 2018 Ken Spencer
# -> License: MIT
##########
require 'site_hook/methods'
require 'site_hook/exceptions'
module SiteHook
  # Paths: Paths to gem resources and things
  class Paths
    def self.old_dir
      Pathname(Dir.home).join('.jph')
    end
    def self.old_config
      Pathname(Dir.home).join('.jph', 'config')
    end
    def self.old_logs
      Pathname(Dir.home).join('.jph', 'logs')
    end
    def self.dir
      Pathname(Dir.home).join('.shrc')
    end
    def self.config
      Pathname(Dir.home).join('.shrc', 'config')
    end

    def self.logs
      Pathname(Dir.home).join('.shrc', 'logs')
    end

    def self.lib_dir
      if ENV['BUNDLE_GEMFILE']
        Pathname(ENV['BUNDLE_GEMFILE']).dirname.join('lib')
      else
        Pathname(::Gem.user_dir).join('gems', "site_hook-#{SiteHook::VERSION}", 'lib')
      end

    end
    def self.make_log_name(klass, level, old_exists = self.old_logs.exist?, new_exists = self.logs.exist?)
      case old_exists
      when true
        self.old_logs.join("#{SiteHook::Methods.safe_log_name(klass)}-#{level}.log").to_s
      when false
        if new_exists
          self.logs.join("#{SiteHook::Methods.safe_log_name(klass)}-#{level}.log").to_s
        else
          raise SiteHook::NoLogsError.new()
        end

      end
    rescue Errno::ENOENT => e

    end
  end
end
