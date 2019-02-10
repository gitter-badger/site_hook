Feature: Get help via the command line
  Scenario: Get Help

    When I run `bundle exec bin/site_hook debug sys-info`
    Then the output should contain:
    """
Gem Name: site_hook
Gem Constant: SiteHook
Gem Author: Ken Spencer <me@iotaspencer.me>
Gem Version: v
    """