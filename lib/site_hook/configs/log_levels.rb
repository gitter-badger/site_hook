require 'configurability'
require 'site_hook/config'
module SiteHook
  module Configs
    class LogLevels
      extend Configurability
      configurability(:log_levels) do
        setting :app, default: 'info'
        setting :build, default: 'info'
        setting :git, default: 'info'
        setting :hook, default: 'info'
      end
    end
  end
end