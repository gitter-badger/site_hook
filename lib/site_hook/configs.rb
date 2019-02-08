require 'site_hook/config'
require 'site_hook/configs/webhook'
require 'site_hook/configs/log_levels'
require 'site_hook/configs/projects'
require 'site_hook/configs/cli'
module SiteHook
  module Configs
    module_function
    def configs
      # @configs = [
      #     SiteHook::Configs::Webhook,
      #     SiteHook::Configs::LogLevels,
      #     SiteHook::Configs::Projects,
      #     SiteHook::Configs::Cli
      # ]
      @configs = SiteHook::Config.new.config
    end
    def reload
      configs
      @configs.each do |name, config|
        puts "Reloading '#{name}'"
        config.reload
        puts "Reloaded '#{name}'"
      end
    end
  end
end