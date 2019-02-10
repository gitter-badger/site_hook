require 'configurability'
require 'site_hook/config'
require 'site_hook/configs'
module SiteHook
  class Methods
    def self.mklogdir
      path = (SiteHook::Paths.logs || SiteHook::Paths.old_logs)
      if path.exist?
        # Path exists, don't do anything
      else
        FileUtils.mkpath(path.to_s)
      end
    end
    def self.safe_log_name(klass)
      klass.class.name.split('::').last.underscore
    end
    # @param [String] hook_name the hook name as defined in the projects:... directive
    def self.find_hook(hook_name)
      project_objs = SiteHook::Configs::Projects.constants
      ret_val = project_objs.detect do |obj|
        SiteHook::Configs::Projects.const_get(obj.to_s).real_key.to_s == hook_name.to_s
      end
      if ret_val.nil?
        return nil
      elsif ret_val
        return SiteHook::Configs::Projects.const_get(ret_val)
      end
    end
  end
end