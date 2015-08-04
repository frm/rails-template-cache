require "rails_templatecache/engine"

module RailsTemplateCache
  mattr_accessor :templates
  autoload :Template, 'rails_templatecache/template'
end
