module RailsTemplateCache
  require 'htmlcompressor'

  class Template
    def initialize(file, markup, options = {})
      silence_warnings do
        @template = Tilt[markup].new(file)
        @opts = options
      end
    end

    def render
      @opts[:compress] ? compress_html(@template.render) : @template.render
    end
  private

    def compress_html(html)
      @compressor ||= HtmlCompressor::Compressor.new
      @compressor.compress(html)
    end
  end
end
