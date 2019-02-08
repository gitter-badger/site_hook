require 'configurability'
module SiteHook
  module Configs
    class Projects
      extend Configurability
      configurability(:projects) do
        # No easy settings, projects can be generated and input via the config commands
      end
    end
  end
end