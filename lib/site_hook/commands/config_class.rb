require 'gli'
require 'highline'
require 'random_password'
require 'yaml'
require 'site_hook/config'
module SiteHook


  # *ConfigClass*
  #
  # Holds all of the commands for the config subcommand
  class App
    extend GLI::App

    desc 'Configure site_hook options'

    # rubocop:disable Metrics/AbcSize
    command 'config' do |c|
      c.command 'gen' do |gen|
        gen.desc "Generate a example config file if one doesn't exist"
        gen.action do |global_options, options, arguments|

          yaml = [
              '# fatal, error, warn, info, debug',
              'log_levels:',
              '  hook: info',
              '  build: info',
              '  git: info',
              '  app: info',

          ]
          shrc = SiteHook::Paths.config
          if shrc.exist?
            puts "#{shrc} exists. Will not overwrite."
          else
            File.open(shrc, 'w') do |f|
              yaml.each do |line|
                f.puts line
              end
            end
            say "Created #{shrc}"
            say "You can now edit #{shrc} and add your projects."
          end
        end
      end
      desc 'generates a project block'
      c.command 'gen-project' do |gen_project|
        gen_project.action do |global_options, options, arguments|
          SiteHook::NotImplemented.declare(gen_project)
          # puts tpl
        end
      end
      c.command 'add-project' do |add_project|
        add_project.action do |global_options, options, arguments|
          # @config_hash = SiteHook::Config::Set.new(SiteHook::Paths.config)
          SiteHook::NotImplemented.declare(add_project)
        end
      end

      c.command 'mkpass' do |mkpass|
        mkpass.flag('symbol-amt', arg_name: 'AMT', type: Integer, default_value: 0)
        mkpass.flag('length', arg_name: 'LENGTH', type: Integer, default_value: 10)
        mkpass.action do |global_options, options, arguments|

          if (8..255).include?(options[:length])
            if (0..128).member?(options[:'symbol-amt'])
              puts RandomPassword.generate(length: options[:length], symbols: options['symbol-amt'])
            else
              help_now! "Symbols amount must be between '0' and '128'."
            end
          else
            help_now! "Length must be a positive 'Integer' between '8' and '255'"
          end
        end
      end
    end
  end
end


# rubocop:enable Metrics/AbcSize
