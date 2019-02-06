##########
# -> File: /home/ken/RubymineProjects/site_hook/lib/site_hook/config_class.1.rb
# -> Project: site_hook
# -> Author: Ken Spencer <me@iotaspencer.me>
# -> Last Modified: 1/10/2018 21:45:36
# -> Copyright (c) 2018 Ken Spencer
# -> License: MIT
##########
require 'site_hook/persist'
require 'site_hook/paths'
require 'site_hook/const'
require 'gli'
module SiteHook
  autoload :Webhook, 'site_hook/webhook'
  SHRC = YAML.load_file(SiteHook::Paths.config) || YAML.load_file(SiteHook::Paths.old_config)
  # *ServerClass*
  #
  # Holds all of the commands for the config subcommand
  class App
    extend GLI::App

    command 'server' do |c|
      c.desc 'Start the server'
      c.command 'listen' do |listen|
        listen.desc 'Start SiteHook'
        listen.flag :log_levels, type: :hash, arg_name: 'LEVELS', default: SiteHook::Logs.log_levels
        listen.flag :host, type: :string, arg_name: 'BINDHOST', default: SHRC.fetch('host', '127.0.0.1')
        listen.flag :port, type: :numeric, arg_name: 'BINDPORT', default: SHRC.fetch('port', 9090)
        listen.action do |global_options, options, arguments|
          SiteHook::Webhook.set_options(options[:host], options[:port])
          SiteHook.mklogdir unless SiteHook::Paths.logs.exist?
          SiteHook::Webhook.run!
        end
      end
    end

  end
end
# rubocop:enable Metrics/AbcSize
