require 'site_hook/const'

module SiteHook
  class Options
    def self.set_options(global, local)
      global.each do |option, value|
        Options.class_variable_set(:"@@global-#{option}", value)
      end
      local.each do |option, value|
        Options.class_variable_set(:"@@local-#{option}", value)
      end
    end
  end
end
