require 'open3'
require 'site_hook/logger'
require 'git'
require 'paint'
module SiteHook
  module Senders
    class Jekyll
      attr :jekyll_source, :build_dest

      class Build

        def do_grab_version
          jekyll_source = Jekyll.instance_variable_get('@jekyll_source')
          build_dest    = Jekyll.instance_variable_get('@build_dest')
          log           = Jekyll.instance_variable_get('@log')
          begin
            stdout_str, status = Open3.capture2({'BUNDLE_GEMFILE' => Pathname(jekyll_source).join('Gemfile').to_path}, "jekyll --version --source #{jekyll_source}")
            log.info("Jekyll Version: #{stdout_str}")
          rescue Errno::ENOENT
            log.fatal('Jekyll not installed! Gem and Webhook will not function')
            Process.kill('INT', Process.pid)
          end
        end

        def do_pull
          fakelog = SiteHook::HookLogger::FakeLog.new
          reallog = SiteHook::HookLogger::GitLog.new.log
          jekyll_source = Jekyll.instance_variable_get('@jekyll_source')
          build_dest    = Jekyll.instance_variable_get('@build_dest')
          g             = Git.open(jekyll_source, :log => fakelog)
          g.pull
          fakelog.entries.each do |level, entries|
            entries.each { |entry| reallog.send("#{level}", entry) }
          end
        end

        def do_build
          jekyll_source = Jekyll.instance_variable_get('@jekyll_source')
          build_dest    = Jekyll.instance_variable_get('@build_dest')
          log        = Jekyll.instance_variable_get('@log')
          begin
            Open3.popen2e({'BUNDLE_GEMFILE' => Pathname(jekyll_source).join('Gemfile').to_path}, "bundle exec jekyll build --source #{Pathname(jekyll_source).to_path} --destination #{Pathname(build_dest).to_path}") { |in_io, outerr_io, thr|
              pid = thr.pid

              outerr = outerr_io.read.lines
              outerr.each do |line|
                line = Paint.unpaint(line)
                line.squish!
                # Configuration file: /home/ken/sites/iotaspencer.me/_config.yml
                # Source: /home/ken/sites/iotaspencer.me
                # Destination: /var/www/iotaspencer.me
                # Incremental build: disabled. Enable with --incremental
                # Generating...
                # GitHub Metadata: No GitHub API authentication could be found. Some fields may be missing or have incorrect data.
                # done in 6.847 seconds.
                # Auto-regeneration: disabled. Use --watch to enable.
                case
                when line =~ /done in .* seconds/
                  log.info(line)
                when line =~ /Generating/
                  log.info(line)
                when line =~ /Configuration file:|Source:|Destination:/
                  log.debug(line)
                when line =~ /Incremental|Auto-regeneration/
                  print ''
                else
                  print ''
                end
              end
              exit_status = thr.value
            }
          end
        end
      end

      def self.build(jekyll_source, build_dest, logger:)
        @jekyll_source = jekyll_source
        @build_dest    = build_dest
        @log           = logger
        instance       = self::Build.new
        meths          = instance.methods.select { |x| x =~ /^do_/ }

        meths.each do |m|
          @log.debug("Running #{m}")
          instance.method(m).call
          @log.debug("Ran #{m}")
        end
      end
    end
  end
end
