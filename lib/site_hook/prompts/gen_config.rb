module SiteHook
  class GenConfig
    # @param [HighLine]
    def initialize(hl)
      @hl = hl

    end
    def prompt_project
      @hl.say "First What's the name of the project?"
      project_name = @hl.ask('> ')

      @hl.say "What's the source path? e.g. /home/#{ENV['USER']}/sites/site.tld"
      source_path = @hl.ask('> ')

      @hl.say 'Where is the web root? e.g. /var/www/sites/site.tld'
      dest_path = @hl.ask('> ')

      @hl.say 'The next things are for the public webhook list.'
      @hl.say "\n"
      @hl.say "\n"
      @hl.say "What's the hostname of the git service? e.g. github.com,"
      @hl.say "gitlab.com, git.domain.tld"
      git_host = @hl.ask('> ')

      @hl.say "What's the repo path? e.g. UserName/SiteName, UserName/site, etc."
      repo_path = @hl.ask('> ')

      @hl.say 'Is this repo allowed to be shown publically?'
      is_private = @hl.agree('> ', true) ? true : false

      @hl.say "Generating a hook password for you. If this one isn't wanted"
      @hl.say "then just change it afterwards using '#{exe_name} config mkpass'."
      hook_pass = RandomPassword.new(length: 20, symbols: 0).generate
      @hl.say 'Done.'
      @hl.say 'Outputting...'
      [
          "  #{project_name}:",
          "    src: #{source_path}",
          "    dst: #{dest_path}",
          "    hookpass: #{hook_pass}",
          "    host: #{git_host}",
          "    repo: #{repo_path}",
          "    private: #{is_private}"
      ]

    end
  end
end