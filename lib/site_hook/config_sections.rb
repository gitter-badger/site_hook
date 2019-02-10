require 'yaml'
module SiteHook
  module ConfigSections
    autoload :Cli, 'site_hook/config_sections/cli'
    autoload :LogLevels, 'site_hook/config_sections/log_levels'
    autoload :Projects, 'site_hook/config_sections/projects'
    module_function
    def example_config
      [Cli.example, LogLevels.example, Projects.example].flatten(1)

    end
  end
end