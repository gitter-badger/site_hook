require 'configurability'
require 'site_hook/config'
module SiteHook
  module Configs
    class Projects
      extend Configurability
      configurability(:projects) do
      end
      @@projects = Hash.new
      @@consts = []
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
        @@projects.store(klass, project)
        Projects.const_set(klass, project)
      end
      def self.each(name, &block)

        const_get(name).each(&block)
        self

      end
      def self.projects
        @@projects
      end
    end
  end
end
