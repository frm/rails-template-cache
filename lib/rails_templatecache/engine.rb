module RailsTemplateCache
  class Engine < ::Rails::Engine
    isolate_namespace RailsTemplateCache

    initializer "rails-templatecache" do |app|
      # TODO: Change base to a value set on config
      templates = ['app', 'assets', 'javascripts']
      templates_path = File.join(templates)
      base = Rails.root.join(templates_path)

      # TODO: Change this to a value in config
      exts = "{#{ %w(slim html haml).join(',') }}"

      assets = {}
      # TODO: add a flag to allow/disallow deep recursive search
      Dir.glob("#{base}/**/*.#{exts}").each do |f|
        # TODO: Add Tilt here
        app.assets.depend_on(f) # TODO: fix caching here
        match = f.match(/#{templates_path}\/(.*)(\.\w+)/)
        key, ext = match[1], match[2]
        # TODO: Add html compressor option
        assets[key] = RailsTemplateCache::Template.new(f, ext)
      end

      RailsTemplateCache.templates = assets
    end
  end
end
