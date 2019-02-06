module SiteHook
  module ConfigSections
    class Cli

      def self.example
        [
            'cli:',
            '  config:',
            '    mkpass:',
            '      symbols: 0',
            '      length: 8',
            '    gen-project:',
            '      config-file: _config.yml',
            '    add-project:',
            '    gen:'




        ]
      end
    end
  end
end