require 'site_hook/paths'
require 'configurability'
require 'site_hook/configs'

module SiteHook
  class Config
    attr_accessor :config
    def initialize
      case SiteHook::Paths.config.exist?
      when false # Old Config
        @filename   = SiteHook::Paths.old_config
      when true # New Config
        @filename   = SiteHook::Paths.config
      else
        # Shouldn't happen
      end
      begin
      @config = Configurability::Config.load(@filename)
      Configurability.configure_objects(@config)
      rescue NoMethodError => e
        puts @filename.empty?
      end
    end
  end
end
