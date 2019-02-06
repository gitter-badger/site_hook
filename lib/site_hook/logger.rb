require 'paint'
require 'logging'
require 'pathname'
require 'active_support/core_ext/string'

Logging.init %w(NONE DEBUG INFO WARN ERROR FATAL)
Logging.color_scheme(
    'bright',
    :levels  => {
        :debug => [:yellow, :on_white],
        :info  => :blue,
        :warn  => :yellow,
        :error => :red,
        :fatal => [:red, :on_white],
    },
    :date    => :white,
    :logger  => :cyan,
    :message => :green,
    )
PATTERN = '[%d] %-5l %c: %m\n'
DATE_PATTERN = '%Y-%m-%d %H:%M:%S'
layout = Logging.layouts.pattern \
  :pattern      => PATTERN,
  :date_pattern => DATE_PATTERN,
  :color_scheme => 'bright'

Logging.appenders.stdout \
  :layout => layout

module SiteHook
  def mklogdir
    path = Pathname(Dir.home).join('.jph', 'logs')
    if path.exist?
      # Path exists, don't do anything
    else
      FileUtils.mkpath(path.to_s)
    end
  end

  def safe_log_name(klass)
    klass.class.name.split('::').last.underscore
  end

  module_function :mklogdir, :safe_log_name

  class LogLogger
    attr :log
    attr :log_level

    def initialize(log_level = 'info') # only change this to debug when testing
      @log    = Logging.logger[SiteHook.safe_log_name(self)]
      @log_level = log_level

      flayout = Logging.appenders.rolling_file \
        Pathname(Dir.home).join('.jph', 'logs', "#{SiteHook.safe_log_name(self)}-#{@log_level}.log").to_s,
        :age     => 'daily',
        :pattern => PATTERN
      @log.add_appenders 'stdout', flayout
      @log.level = log_level
    end
  end

  mklogdir
  LL = LogLogger.new.log
  LL.debug "#{SiteHook.safe_log_name(LL.class)} initialized."

  class HookLogger

    # Log App Actions
    class AppLog
      attr :log
      attr :log_level

      def initialize(log_level = nil)
        LL.debug "Initializing #{SiteHook.safe_log_name(self)}"
        @log    = Logging.logger[SiteHook.safe_log_name(self)]
        @log_level = log_level

        flayout = Logging.appenders.rolling_file \
          Pathname(Dir.home).join('.jph', 'logs', "#{SiteHook.safe_log_name(self)}-#{@log_level}.log").to_s,
          :age     => 'daily',
          :pattern => PATTERN
        @log.add_appenders 'stdout', flayout
        @log.level = log_level
        LL.debug "Initialized #{SiteHook.safe_log_name(self)}"
      end
    end

    # Log Hook Actions
    class HookLog
      attr :log
      attr :log_level

      def initialize(log_level = nil)
        LL.debug "Initializing #{SiteHook.safe_log_name(self)}"
        @log    = Logging.logger[SiteHook.safe_log_name(self)]
        @log_level = log_level
        flayout = Logging.appenders.rolling_file \
          Pathname(Dir.home).join('.jph', 'logs', "#{SiteHook.safe_log_name(self)}-#{@log_level}.log").to_s,
          :age     => 'daily',
          :pattern => PATTERN
        @log.add_appenders 'stdout', flayout
        @log.level = @log_level
        LL.debug "Initialized #{SiteHook.safe_log_name(self)}"
      end
    end

    # Log Build Actions
    class BuildLog
      attr :log

      def initialize(log_level = nil)
        LL.debug "Initializing #{SiteHook.safe_log_name(self)}"
        @log    = Logging.logger[SiteHook.safe_log_name(self)]
        @log_level = log_level

        flayout = Logging.appenders.rolling_file \
          Pathname(Dir.home).join('.jph', 'logs', "#{SiteHook.safe_log_name(self)}-#{@log_level}.log").to_s,
          :age     => 'daily',
          :pattern => PATTERN
        @log.add_appenders 'stdout', flayout
        @log.level = log_level

        LL.debug "Initialized #{SiteHook.safe_log_name(self)}"
      end
    end

    # Log Git Actions
    class GitLog
      attr :log

      def initialize(log_level = nil)
        LL.debug "Initializing #{SiteHook.safe_log_name(self)}"
        @log    = Logging.logger[SiteHook.safe_log_name(self)]
        @log_level = log_level

        flayout = Logging.appenders.rolling_file \
          Pathname(Dir.home).join('.jph', 'logs', "#{SiteHook.safe_log_name(self)}-#{@log_level}.log").to_s,
          :age     => 'daily',
          :pattern => PATTERN
        @log.add_appenders 'stdout', flayout
        @log.level = log_level
        LL.debug "Initialized #{SiteHook.safe_log_name(self)}"
      end
    end

    # Fake Logger for GitLog to preprocess output
    class FakeLog < StringIO
      attr :info_output, :debug_output
      def initialize
        @info_output = []
        @debug_output = []
      end
      # @param [Any] message message to log
      def info(message)
        case
        when message =~ /git .* pull/
          @info_output << "Starting Git"
          @debug_output << message
        else
          @debug_output << message
        end
      end
      # @param [Any] message message to log
      def debug(message)
        case
        when message =~ /\n/
          msgs = message.lines
          msgs.each do |msg|
            msg.squish!
            case
            when msg =~ /From (.*?):(.*?)\/(.*)(\.git)?/
              @info_output << "Pulling via #{$2}/#{$3} on #{$1}."
            when msg =~ /\* branch (.*?) -> .*/
              @info_output << "Using #{$1} branch"
            else
              @debug_output << msg
            end
          end
        else
          @debug_output << message
        end
      end

      # @return [Hash] Hash of log entries
      def entries
        {
            info: @info_output,
            debug: @debug_output
        }
      end
    end
  end
end
