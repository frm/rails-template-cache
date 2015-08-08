module RailsTemplateCache
  class HtmlProcessor
    VERSION = '1'

    def self.cache_key
      @cache_key ||= [self.class.name, VERSION].freeze
    end

    def self.call(input)
      binding.pry
      html = compressable? ? compress_html(input[:data]) : input[:data]
      RailsTemplateCache.templates[input[:name]] = html
      # Update input hash here
      html
    end

  private

    def self.compressable?
      RailsTemplateCache.config.rails_template_cache.compress_html
    end

    def self.compress_html(html)
      @compressor ||= HtmlCompressor::Compressor.new
      @compressor.compress(html)
    end
  end
end
