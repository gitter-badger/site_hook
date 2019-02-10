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
    subcommand_option_handling :normal
    program_desc ''
    commands_from 'site_hook/commands'

    around do |global_options, command, options, args, code|
      code.call
    end
    on_error do |exception|
      case exception
      when SiteHook::DeprecationError
        puts "#{exception}"
        false
      when Errno::ENOENT
        puts exception.methods
        false
      when SystemExit
        exit(0)
      else
        true
      end

    end
    pre do |global_options, command, options, args|
      @hl          = HighLine.new($stdin, $stdout, 80, 1, 2, 0)
      SiteHook::Config.new
      SiteHook::Config.cfg_obj
      SiteHook::Config.make_projects
      if SiteHook::Paths.old_config.exist?
        @deprecation = SiteHook::Deprecation.deprecate_config(command)
        if @deprecation[:exit]
          SiteHook::Deprecation.raise_error(@deprecation[:msg])
          @deprecation[:exit]
        else
          puts @deprecation[:msg]
          true
        end
      else
        true
      end
    end
  end
end
# Signal.trap('HUP') do
#   puts "reloading config due to 'HUP' Signal"
#   SiteHook::Configs::Projects.reload
#   SiteHook::Configs::LogLevels.reload
#   SiteHook::Configs::Webhook.reload
# end


