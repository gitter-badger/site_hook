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
  end
end