require 'configurability'
require 'site_hook/config'
module SiteHook
  module Configs
    class Projects
      def self.init(project_name, klass)
        project = Class.new do
          extend Configurability
          configurability("projects__#{project_name}") do
            setting :src, default: '/path/to/src'
            setting :dst, default: '/path/to/build_destination'
            setting :host, default: 'github.com'
            setting :repo, default: 'your/repo'
            setting :hookpass, default: 'm15c0nf1gured--change-me'
            setting :private, default: false
          end
        end
        Projects.const_set(klass, project)
      end
    end
  end
end