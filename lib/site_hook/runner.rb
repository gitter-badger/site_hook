require 'site_hook'
module SiteHook
  class Runner
    def initialize(argv = ARGV, stdin = STDIN, stdout = STDOUT, stderr = STDERR, kernel = Kernel)
      @@argv, @@stdin, @@stdout, @@stderr, @@kernel = argv, stdin, stdout, stderr, kernel
    end
    def self.execute!
      exit_code = begin
        $stderr = @@stderr
        $stdin = @@stdin
        $stdout = @@stdout
        SiteHook::App.run(@@argv)
      rescue StandardError => e
        b = e.backtrace
        STDERR.puts("#{b.shift}: #{e.message} (#{e.class})")
        STDERR.puts(b.map{|s| "\tfrom #{s}"}.join("\n"))
        1
      rescue SystemExit => e
        e.status
      ensure
        $stderr = STDERR
        $stdin = STDIN
        $stdout = STDOUT
      end
      @@kernel.exit(exit_code)
    end
  end
end