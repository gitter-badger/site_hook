require "bundler/gem_tasks"
require 'rake/testtask'
require "site_hook"
require 'minitest/expectations'
require 'minitest/mock'
require 'minitest/test'
require 'minitest/autorun'

Rake::TestTask.new do |t|
  t.test_files = FileList['tests/**/*_test.rb']
end
desc 'Run tests'

task default: :test