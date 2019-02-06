require 'site_hook/log'
require 'site_hook/logger'
module SiteHook
  class Consts
    HOOKLOG = SiteHook::HookLogger::HookLog.new(SiteHook::Logs.log_levels['hook']).log
    BUILDLOG = SiteHook::HookLogger::BuildLog.new(SiteHook::Logs.log_levels['build']).log
    APPLOG = SiteHook::HookLogger::AppLog.new(SiteHook::Logs.log_levels['app']).log
    SHRC = YAML.load_file(Pathname(Dir.home).join('.jph', 'config'))
  end
end