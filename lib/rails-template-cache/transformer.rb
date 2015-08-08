module RailsTemplateCache
  class Transformer
    VERSION = '1'

    attr_reader :cache_key

    def initialize(options = {})
      @cache_key = [self.class.name, VERSION, options].freeze
    end

    def self.instance
      @instance ||= new
    end

    def self.call(input)
      instance.call(input)
    end

    def self.cache_key
      instance.cache_key
    end

    def call(input)
      binding.pry
      # Update input hash here
      Tilt[extension].new(input[:filename]).render
    end

    def self.transformer_for(ext)
      # TODO: pass ext to block
      Class.new(self) do
        def extension
          ext
        end
      end
    end

  private

    def extension
      # Subclasses override this method
      raise NoMethodError
    end
  end
end
