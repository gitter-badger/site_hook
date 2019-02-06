require 'site_hook/paths'
require 'recursive_open_struct'

module SiteHook
  class Config
    attr_reader :raw_config, :config, :filename

    def initialize
      case SiteHook::Paths.config.exist?
      when false # Old Config
        @raw_config = YAML.load_file(SiteHook::Paths.old_config.to_s)
        @filename   = SiteHook::Paths.old_config
      when true # New Config
        @raw_config = YAML.load_file(SiteHook::Paths.config.to_s)
        @filename   = SiteHook::Paths.config
      else
        # Shouldn't happen
      end
      @config = RecursiveOpenStruct.new(@raw_config, recurse_over_arrays: true, preserve_original_keys: true)
    end
  end
end