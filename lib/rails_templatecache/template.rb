module RailsTemplateCache
  class Template
    def initialize(file, markup, options = {})
      silence_warnings do
        @template = Tilt[markup].new(file)
        @opts = options
      end
    end

    def render
      # TODO: Add html compressor option
      @template.render
    end
  end
end
