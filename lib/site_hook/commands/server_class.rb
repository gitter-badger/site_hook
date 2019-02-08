##########
# -> File: /home/ken/RubymineProjects/site_hook/lib/site_hook/config_class.1.rb
# -> Project: site_hook
# -> Author: Ken Spencer <me@iotaspencer.me>
# -> Last Modified: 1/10/2018 21:45:36
# -> Copyright (c) 2018 Ken Spencer
# -> License: MIT
##########
require 'site_hook/paths'
require 'site_hook/const'
require 'site_hook/configs'
require 'gli'
module SiteHook
  autoload :Webhook, 'site_hook/webhook'
  # *ServerClass*
  #
  # Holds all of the commands for the config subcommand
  class App
    extend GLI::App
    desc 'Run Server actions'
    command 'server' do |c|
      c.desc 'Start the server'
      c.command 'listen' do |listen|
        listen.desc 'Start SiteHook'
        listen.flag :log_levels, type: :hash, arg_name: 'LEVELS', default: SiteHook::Configs::LogLevels.default_config
        listen.flag :host, type: :string, arg_name: 'BINDHOST', default_value: SiteHook::Configs::Webhook.host
        listen.flag :port, type: :numeric, arg_name: 'BINDPORT', default_value: SiteHook::Configs::Webhook.port
        listen.action do |global_options, options, arguments|
          @threads = []
          SiteHook::Webhook.set_options(options[:host], options[:port])
          SiteHook::Methods.mklogdir unless SiteHook::Paths.logs.exist?
          # @threads.each(&:exit)
          @threads << Thread.new do
            while true
              case STDIN.gets
              when "reload\n"
                ::SiteHook::Configs.reload
              when "quit\n"
                Thread.list.each do |thr|
                  thr == Thread.current ? exit(0) : thr.exit
                end
              end
            end
          end
          @threads << Thread.new do
            SiteHook::Webhook.run!
          end
          @threads.each(&:join)
          puts Thread.list
        end
      end
    end
  end
end
# rubocop:enable Metrics/AbcSize
