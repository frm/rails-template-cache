require "rails-template-cache/template"
require "rails-template-cache/engine"

module RailsTemplateCache
  mattr_accessor :templates
  self.templates ||= {}

  def self.setup(&block)
    set_config
    yield @@config.rails_template_cache if block
    @@config.rails_template_cache
  end

  def self.config
    Rails.application.config
  end

  private

  def self.set_config
    unless @config
      @@config = RailsTemplateCache::Engine::Configuration.new
      @@config.rails_template_cache = ActiveSupport::OrderedOptions.new
    end
  end
end
