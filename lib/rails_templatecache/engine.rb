module RailsTemplateCache
  class Engine < ::Rails::Engine
    isolate_namespace RailsTemplateCache

    config.before_configuration do |app|
      RailsTemplateCache.setup do |rtc_config|
        rtc_config.compress_html = true
        rtc_config.templates_path = File.join( ['app', 'assets', 'javascripts'] )
        rtc_config.extensions = %w(slim html haml)
      end
    end

    initializer "rails-templatecache" do |app|
      base = Rails.root.join(config.rails_templatecache.templates_path)
      exts = "{#{ config.rails_templatecache.extensions.join(',') }}"
      assets = {}

      # TODO: add a flag to allow/disallow deep recursive search
      Dir.glob("#{base}/**/*.#{exts}").each do |f|
        match = f.match(/#{config.rails_templatecache.templates_path}\/(.*)(\.\w+)/)
        key, ext = match[1], match[2]
        app.assets.depend_on(f) # TODO: fix caching here
        assets[key] = RailsTemplateCache::Template.new(f, ext, compress: config.rails_templatecache.compress_html)
      end

      RailsTemplateCache.templates = assets
    end
  end
end
