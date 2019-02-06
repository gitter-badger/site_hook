require 'site_hook/log'
require 'site_hook/logger'
require 'site_hook/config'
module SiteHook
  class Consts
    HOOKLOG = SiteHook::HookLogger::HookLog.new(SiteHook::Logs.log_levels['hook']).log
    BUILDLOG = SiteHook::HookLogger::BuildLog.new(SiteHook::Logs.log_levels['build']).log
    APPLOG = SiteHook::HookLogger::AppLog.new(SiteHook::Logs.log_levels['app']).log
    SHRC = SiteHook::Config.new.config.to_h
  end
end