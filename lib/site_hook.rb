# frozen_string_literal: true

require 'site_hook/version'
require 'site_hook/sender'
require 'site_hook/gem'
require 'site_hook/log'
require 'site_hook/logger'
require 'site_hook/spinner'
require 'recursive-open-struct'
require 'site_hook/cli'
require 'sinatra'
require 'haml'
require 'sass'
require 'json'
require 'sinatra/json'
require 'yaml'

module SiteHook
  autoload :Logs, 'site_hook/log'
  autoload :Gem, 'site_hook/gem'
  autoload :Paths, 'site_hook/paths'
  # class SassHandler (inherits from Sinatra::Base)
  module_function
  def self.set_options(name, value)
    SiteHook.const_set("#{name.upcase}", value)
  end
  class SassHandler < Sinatra::Base
    set :views, Pathname(app_file).dirname.join('site_hook', 'static', 'sass').to_s
    get '/css/*.css' do
      filename = params[:splat].first
      scss filename.to_sym, cache: false
    end
  end
  # class CoffeeHandler (inherits from Sinatra::Base)
  class CoffeeHandler < Sinatra::Base
    set :views, Pathname(app_file).dirname.join('site_hook', 'static', 'coffee').to_s
    get '/js/*.js' do
      filename = params[:splat].first
      coffee filename.to_sym
    end
  end
end
