lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'site_hook/version'

Gem::Specification.new do |spec|
  spec.name = 'site_hook'
  spec.version = SiteHook::VERSION
  spec.authors = ['Ken Spencer']
  spec.email = ['me@iotaspencer.me']

  spec.summary = %q{Catch a POST request from a git service push webhook and build a jekyll site.}
  spec.homepage = 'https://iotaspencer.me/projects/site_hook/'
  spec.license = 'MIT'
  spec.licenses = ['MIT']
  spec.required_ruby_version = '>= 2.3'
  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  spec.metadata = {
    'source_uri' => 'https://github.com/IotaSpencer/site_hook',
    'source_code_uri' => 'https://github.com/IotaSpencer/site_hook',
    'tutorial_uri' => 'https://iotaspencer.me/projects/site_hook/',
    'documentation_uri' => 'https://iotaspencer.me/projects/site_hook'

  }
  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(tests)/})
  end
  spec.bindir = 'bin'
  spec.executables = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
  spec.add_runtime_dependency 'configurability', '~> 3.3.0'
  spec.add_runtime_dependency 'git', '~> 1.3'
  spec.add_runtime_dependency 'gli', '~> 2.18.0'
  spec.add_runtime_dependency 'haml', '~> 5.0'
  spec.add_runtime_dependency 'highline', '~> 2.0', '>= 2.0.0'
  spec.add_runtime_dependency 'logging', '~> 2.2'
  spec.add_runtime_dependency 'paint', '~> 2.0'
  # spec.add_runtime_dependency 'public_suffix', '>= 3.0.3'
  # spec.add_runtime_dependency 'addressable', '>= 2.5.2'
  spec.add_runtime_dependency 'random_password', '~> 0.1.1'
  spec.add_runtime_dependency 'recursive-open-struct', '~> 1.1'
  spec.add_runtime_dependency 'sinatra', '~> 2.0.2', '>= 2.0.5'
  # spec.add_runtime_dependency 'sinatra-contrib', '~> 2.0', '>= 2.0.5'
  spec.add_runtime_dependency 'thin', '~> 1.7'


  spec.post_install_message = <<~POSTINSTALL
    site_hook 0.9.* introduces breaking configuration changes!
    .shrc/config -> root:host and root:port directives should now be located in
    root:webhook:host and root:webhook:port

    Tutorials on site_hook configuration, installation and setup
    can be seen on https://iotaspencer.me/projects/site_hook

  POSTINSTALL
end
