require 'site_hook/paths'
require 'configurability'
require 'configurability/config'
require 'site_hook/configs'

module SiteHook
  class Config
    attr_accessor :config, :projects

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
        @projects = @config.projects
        @@projects = @config.projects
      rescue NoMethodError => e
        puts @filename.empty?
      end
    end
    def self.projects
      @@projects
    end
    def self.make_projects
      @@cfg_obj.projects.each do |key, section|
        real_key = key
        key_name = key.to_s.scan(/\w+/).collect(&:capitalize).join
        SiteHook::Configs::Projects.init(real_key, key, key_name)
      end
    end

    def self.cfg_obj
      cfg       = Configurability::Config.load(@@filename)

      @@cfg_obj = cfg

      return @@cfg_obj
    end
  end
end
