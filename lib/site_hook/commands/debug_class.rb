##########
# -> File: /home/ken/RubymineProjects/site_hook/lib/site_hook/debug_class.rb
# -> Project: site_hook
# -> Author: Ken Spencer <me@iotaspencer.me>
# -> Last Modified: 6/10/2018 13:14:51
# -> Copyright (c) 2018 Ken Spencer
# -> License: MIT
##########
require 'gli'
require 'pp'

module SiteHook
  # *DebugClass*
  #
  # Holds all of the commands for the debug subcommand
  class App
    extend GLI::App
    hide_commands_without_desc true
    desc 'Debug the Gem'
    command 'debug' do |c|
      c.desc 'Print info on the gem.'
      c.command 'sys-info' do |gem_info|
        gem_info.action do |global_options, options, arguments|
          @hl.say "Gem Name: #{SiteHook::Gem::Info.name}"
          @hl.say "Gem Constant: #{SiteHook::Gem::Info.constant_name}"
          @hl.say "Gem Author: #{SiteHook::Gem::Info.author}"
          @hl.say "Gem Version: v#{SiteHook::VERSION}"
        end
      end
      # c.desc "Return current paths for running site_hook"
      c.command 'paths' do |paths|
        paths.action do |gopts, opts, args|
          home_gem_path = ENV['GEM_HOME']
          puts home_gem_path
          puts Pathname(::Gem.default_path.first).join('lib', 'site_hook')
          # puts .exist?
        end
      end
      c.command 'eval' do |evalcommand|
        evalcommand.switch 'pp', optional: true, default_value: false
        evalcommand.action do |gopts, opts, args|
          if opts[:pp]
            pp eval(args.join(''))
          else
            puts eval(args.join(''))
          end
        end
      end
    end
  end
end
