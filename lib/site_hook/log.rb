
module SiteHook
  autoload :Paths, 'site_hook/paths'
  autoload :Config, 'site_hook/config'
  # Logs
  # Give logs related methods
  module Logs
    module_function
    DEFAULT   = {
        'hook'  => 'info',
        'build' => 'info',
        'git'   => 'info',
        'app'   => 'info'
    }
    def self.log_levels

      log_level = Config.new.config.to_h.fetch('log_levels')
      if log_level
        log_level
      end
    rescue KeyError
      DEFAULT
    rescue Errno::ENOENT
      DEFAULT
    end
  end
end