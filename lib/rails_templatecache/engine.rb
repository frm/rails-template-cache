module RailsTemplateCache
  class Engine < ::Rails::Engine
    isolate_namespace RailsTemplateCache

    initializer "rails-templatecache" do |app|
      # TODO: Change base to a value set on config
      templates = ['app', 'assets', 'javascripts']
      templates_path = File.join(templates)
      base = Rails.root.join(templates_path)
      # TODO: Change this to a value in config
      markups = "{#{%w(html).join(',')}}"

      assets = {}
      # TODO: add a flag to allow/disallow deep recursive search
      Dir.glob("#{base}/**/*.#{markups}").each do |f|
        # TODO: Add Tilt preprocessors here
        app.config.assets.depend_on(f)
        key = f.split(/#{templates_path}\//).last
        assets[key] = File.open(f).read.strip
      end

      RailsTemplateCache.templates = assets
    end
  end
end
