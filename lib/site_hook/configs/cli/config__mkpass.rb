require 'configurability'
module SiteHook
  module Configs
    class Cli
      class Config
        class Mkpass
          extend Configurability
          configurability('cli.config.mkpass') do
            setting :symbols, default: 8 do |value|
              Integer(value) if value
            end
            setting :length, default: 20 do |value|
              Integer(value) if value
            end
          end
        end
      end
    end
  end
end