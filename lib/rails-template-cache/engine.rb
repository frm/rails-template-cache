module RailsTemplateCache
  class Engine < ::Rails::Engine
    isolate_namespace RailsTemplateCache

    config.before_configuration do |app|
      # Setting default options for the setup
      RailsTemplateCache.setup do |rtc_config|
        rtc_config.compress_html = false
        rtc_config.templates_path = File.join( ['app', 'assets', 'javascripts'] )
        rtc_config.extensions = %w(erb haml html slim)
      end
    end

    initializer "rails-template-cache" do |app|
      base = Rails.root.join(config.rails_template_cache.templates_path)
      exts = "{#{ config.rails_template_cache.extensions.join(',') }}"

      Dir.glob("#{base}/**/*.#{exts}").each do |f|
        key, ext = RailsTemplateCache::Template
          .asset_data(f, config.rails_template_cache.templates_path)

        RailsTemplateCache.templates[key] = RailsTemplateCache::Template
          .new(f, ext, compress: config.rails_template_cache.compress_html)
      end

      # Clear cache if config changes
      app.config.assets.version = [
        app.config.assets.version,
        Digest::MD5.hexdigest("#{VERSION}-#{app.config.rails_template_cache}")
      ].join('-')
    end
  end
end
