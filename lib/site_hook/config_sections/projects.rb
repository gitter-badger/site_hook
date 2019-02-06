module SiteHook
  module ConfigSections
    class Projects
      def self.example
        [
            'projects:',
            '  PROJECT.NAME:',
            "    config: _config.yml",
            "    src: /path/2/site/source",
            "    dst: /path/2/destination/",
            "    host: git*.com",
            "    repo: USER/REPO",
            "    hookpass: SOMERANDOMSTRING",
            "    private: true/false"
        ]
      end
      def initialize(**answers)
        @answers = answers
      end
    end
  end
end