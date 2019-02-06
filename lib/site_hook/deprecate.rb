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
