require 'site_hook/log'
require 'site_hook/logger'
require 'site_hook/config'
module SiteHook
  class Consts
    HOOKLOG = SiteHook::HookLogger::HookLog.new(SiteHook::Configs::LogLevels.hook).log
    BUILDLOG = SiteHook::HookLogger::BuildLog.new(SiteHook::Configs::LogLevels.build).log
    APPLOG = SiteHook::HookLogger::AppLog.new(SiteHook::Configs::LogLevels.app).log
  end
end