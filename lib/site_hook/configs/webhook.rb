require 'configurability'
require 'site_hook/config'
module SiteHook
  module Configs
    class Webhook
      extend Configurability
      configurability(:webhook) do
        setting(:host, default: '127.0.0.1')
        setting(:port, default: 9090) do |value|
          Integer(value) if value
        end
      end
    end
  end
end