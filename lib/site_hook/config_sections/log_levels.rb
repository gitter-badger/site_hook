module SiteHook
  module ConfigSections
    class LogLevels
      def self.example
        [
            'log_levels:',
            '  app: info',
            '  build: info',
            '  git: info',
            '  hook: info'
        ]
      end
    end
  end
end