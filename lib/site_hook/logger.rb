require 'paint'
require 'logging'
require 'site_hook/paths'
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

  class HookLogger

    # Log App Actions
    class AppLog
      attr :log
      attr :log_level

      def initialize(log_level = nil)
        @log    = Logging.logger[SiteHook::Paths.make_log_name(self, log_level)]
        @log_level = log_level

        flayout = Logging.appenders.rolling_file \
          SiteHook::Paths.make_log_name(self, log_level),
          :age     => 'daily',
          :pattern => PATTERN
        @log.add_appenders 'stdout', flayout
        @log.level = log_level
      end
    end

    # Log Hook Actions
    class HookLog
      attr :log
      attr :log_level

      def initialize(log_level = nil)
        @log    = Logging.logger[SiteHook::Paths.make_log_name(self, log_level)]
        @log_level = log_level
        flayout = Logging.appenders.rolling_file \
          SiteHook::Paths.make_log_name(self, @log_level),
          :age     => 'daily',
          :pattern => PATTERN
        @log.add_appenders 'stdout', flayout
        @log.level = @log_level
      end
    end

    # Log Build Actions
    class BuildLog
      attr :log
      attr :log_level

      def initialize(log_level = nil)
        @log    = Logging.logger[SiteHook::Paths.make_log_name(self, log_level)]
        @log_level = log_level
        flayout = Logging.appenders.rolling_file \
          SiteHook::Paths.make_log_name(self, @log_level),
          :age     => 'daily',
          :pattern => PATTERN
        @log.add_appenders 'stdout', flayout
        @log.level = log_level
      end
    end

    # Log Git Actions
    class GitLog
      attr :log
      attr :log_level

      def initialize(log_level = nil)
        @log    = Logging.logger[SiteHook::Paths.make_log_name(self, log_level)]
        @log_level = log_level

        flayout = Logging.appenders.rolling_file \
          SiteHook::Paths.make_log_name(self, @log_level),
          :age     => 'daily',
          :pattern => PATTERN
        @log.add_appenders 'stdout', flayout
        @log.level = log_level
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
