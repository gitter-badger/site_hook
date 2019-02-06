require 'site_hook/paths'
require 'recursive_open_struct'

module SiteHook
  class Config
    class Get
      attr_reader :raw_config, :parsed_config, :config
      def initialize(cfg_path = Pathname.new(SiteHook::Paths.config || SiteHook::Paths.old_config))
        @filename = cfg_path
        @raw_config = YAML.load_file(cfg_path)
        @parsed_config = RecursiveOpenStruct.new(@raw_config, recurse_over_arrays: true, preserve_original_keys: true)
        @config = @parsed_config
      end

    end
    class Set
      attr_reader :filename
      def initialize(cfg_path)
        @filename = cfg_path
        @config = YAML.load_file(@filename)
      end
    end
  end
end