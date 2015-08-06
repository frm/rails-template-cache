$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "rails-templatecache/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "rails-templatecache"
  s.version     = RailsTemplateCache::VERSION
  s.authors     = ["Fernando Mendes"]
  s.email       = ["devfrmendes@gmail.com"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of RailsTemplateCache."
  s.description = "TODO: Description of RailsTemplateCache."
  s.license     = "MIT"

  s.files = Dir["{app,lib}/**/*", "MIT-LICENSE", "README.rdoc"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "rails"
  s.add_dependency "railties"
  s.add_dependency "sprockets"
  s.add_dependency "tilt"
  s.add_dependency "htmlcompressor"

  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "rspec-its"
  s.add_development_dependency "capybara"
  s.add_development_dependency "selenium-webdriver"
end
