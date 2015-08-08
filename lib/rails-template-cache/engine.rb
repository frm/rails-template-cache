module RailsTemplateCache
  class Engine < ::Rails::Engine
    isolate_namespace RailsTemplateCache

    def register_transformer_for(ext)
      transformer = RailsTemplateCache::Transformer.transformer_for ext
      mime_type = "text/#{ext}"
      app = Rails.application
      app.assets.register_mime_type mime_type, extensions: [".#{ext}"]
      app.assets.register_transformer mime_type, 'text/html', transformer
    end

    config.before_configuration do |app|
      # Setting default options for the setup
      RailsTemplateCache.setup do |rtc_config|
        rtc_config.compress_html = false
        rtc_config.templates_path = File.join( ['app', 'assets', 'javascripts'] )
        rtc_config.extensions = %w(haml slim html erb)
      end
    end

    initializer "rails-template-cache", group: :all do |app|
      extensions = config.rails_template_cache.extensions
      config.assets.precompile.concat( extensions.map { |f| "*.#{f}" } )

      config.rails_template_cache.extensions.each do |ext|
        register_transformer_for ext
      end

      html_processor = RailsTemplateCache::HtmlProcessor
      app.assets.register_postprocessor 'text/html', html_processor

      # Clear cache if config changes
      app.config.assets.version = [
        app.config.assets.version,
        Digest::MD5.hexdigest("#{VERSION}-#{app.config.rails_template_cache}")
      ].join('-')
    end
  end
end
