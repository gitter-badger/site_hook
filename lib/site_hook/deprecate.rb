module SiteHook
  class Deprecation
    attr_reader :instructions
    def initialize(message, situation, instructions)
      @str = "▼▼▼ [#{Paint['DEPRECATION ERROR', :red, :bold]}] —— The following situation is deprecated! ▼▼▼"
      @situation = situation
      @str << "\n#{@situation}"
      @instructions = instructions
      @str << "\n#{@instructions}"
    end
    def self.deprecate(situation, instructions, continue)
      puts @str if @str
      return continue
    end
    def self.deprecate_config
      self.deprecate(
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
    end
  end
  class NotImplemented
    attr_reader :command_object

    def initialize(command)
      @command_object = command
      @exe_name = @command_object.parent.parent.exe_name
      @output_string = "Command `#{@exe_name} #{command.name_for_help.join(' ')}"
    end
    def self.declare(command)
      instance = self.new(command)
      instance.instance_variable_set(
          :'@output_string',
          "#{instance.instance_variable_get(:'@output_string')}` is not implemented currently")
      puts instance.instance_variable_get(:'@output_string')
    end
  end
end
