require 'configurability'
module SiteHook
  module Configs
    class Cli
      class Config
        extend Configurability
        configurability(:cli__config) do
          # No defaults due to complexity
          setting :mkpass
        end
      end
    end
  end
end