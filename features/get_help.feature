Feature: Get help via the command line

  Scenario: Get Help

    When I run `bundle exec site_hook debug sys-info`
    Then the stdout from "bundle exec site_hook debug sys-info" should contain "Gem Name: site_hook\nGem Constant: SiteHook\nGem Author: Ken Spencer <me@iotaspencer.me>\nGem Version: v"
    And the exit status should be 0
  Scenario: