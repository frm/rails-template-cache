module RailsTemplateCache
  class Template
    attr_reader :source_file

    def initialize(source_file, markup, options = {})
      silence_warnings do
        @template = Tilt[markup]
        @source_file = source_file
        @opts = options
      end
    end

    def render
      # Only render when needed, to avoid caching issues
      rendered_template = @template.new(@source_file).render
      @opts[:compress] ? compress_html(rendered_template) : rendered_template
    end

    def self.asset_data(path, templates_path = "")
      result = []
      case path.to_s
        when /#{templates_path}\/(.*)(\.html)$/
          result = "#{$1}#{$2}", $2
        when /#{templates_path}\/(.*\.html)(\.\w+)$/
          result = $1, $2
        when /#{templates_path}\/(.*)(\.\w+)$/
          result = "#{$1}.html", $2
      end
      result
    end

  private

    def compress_html(html)
      @compressor ||= HtmlCompressor::Compressor.new
      @compressor.compress(html)
    end
  end
end
