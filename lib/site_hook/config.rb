require 'site_hook/paths'
require 'configurability'
require 'configurability/config'
require 'site_hook/configs'

module SiteHook
  class Config
    attr_accessor :config

    def initialize
      case SiteHook::Paths.config.exist?
      when false # Old Config
        @filename  = SiteHook::Paths.old_config
        @@filename = SiteHook::Paths.old_config
      when true # New Config
        @filename  = SiteHook::Paths.config
        @@filename = SiteHook::Paths.config
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

    def self.cfg_obj
      cfg       = Configurability::Config.load(@@filename)
      @@cfg_obj = cfg.projects
      @@cfg_obj.each do |key, section|
        key_name = key.to_s.scan(/\w+/).collect(&:capitalize).join
        SiteHook::Configs::Projects.const_set(key_name, SiteHook::Configs::Projects.init(key, key_name))
      end
    end
  end
end
