require 'minitest/autorun'
require 'test-helper.rb'
class MainTest < Minitest::Test

  # Called before every test method runs. Can be used
  # to set up fixture information.
  def setup
    @app = SiteHook::App
  end

  def make_output


  end

  # Called after every test method runs. Can be used to tear
  # down fixture information.
  def teardown
    # Do nothing
  end

  # test gem-info
  def test_that_gem_info_gets_output
    expected_output = <<-HEREDOC
Gem Name: site_hook
Gem Constant: SiteHook
Gem Author: Ken Spencer <me@iotaspencer.me>
Gem Version: v#{SiteHook::VERSION}
    HEREDOC

    must_output(expected_output, nil)
  end
end