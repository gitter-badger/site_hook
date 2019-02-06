require 'gli'
require 'highline'
require 'paint'
require 'pathname'
require 'site_hook/exceptions'
require 'site_hook/deprecate'
module SiteHook
  class App
    extend GLI::App
    version SiteHook::VERSION
    # don't use config_file just use ~/.shrc/config's cli:...
    # projects are in .shrc/config
    commands_from 'site_hook/commands'
    desc 'Print info on the gem.'
    command 'gem-info' do |c|
      c.action do |global_options, options, arguments|
        @hl.say "Gem Name: #{SiteHook::Gem::Info.name}"
        @hl.say "Gem Constant: #{SiteHook::Gem::Info.constant_name}"
        @hl.say "Gem Author: #{SiteHook::Gem::Info.author}"
        @hl.say "Gem Version: v#{SiteHook::VERSION}"
      end
    end
    around do |global_options, command, options, args, code|
      @config_hash = YAML.load_file(SiteHook::Paths.config) || YAML.load_file(SiteHook::Paths.old_config)
      @hl = HighLine.new(STDIN, STDOUT, 80, 1, 2, 0)
      code.call
    end
    pre do |global_options, command, options, args|
      if SiteHook::Paths.old_config.exist?
        continue = SiteHook::Deprecation.deprecate(
            "#{SiteHook::Paths.old_config.to_s} is deprecated in favor of #{SiteHook::Paths.config}",
            <<~INSTRUCT,
              Please run `#{exe_name} config upgrade-shrc` to rectify this.
              Once version 1.0.0 is released, #{SiteHook::Paths.config} will
              be the only config file option, and #{SiteHook::Paths.old_config} will not be allowed.
              any existance of ~/.jph after the 1.0.0 release will result in an Exception being raised.
              Once the exception is raised, site_hook will exit and return a 99 status code.
            INSTRUCT
                                 true

        )
        continue
      else
        # don't do anything
      end
    end
  end
end
