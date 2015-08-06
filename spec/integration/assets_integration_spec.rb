require 'rails_helper'

describe "RailsTemplateCache inclusion", :type => :feature do
  before do
    @files = RailsTemplateCache.templates.keys
    visit '/assets/rails-template-cache/rails-template-cache.js'
  end

  it "adds templates to angular templateCache" do
    @files.each do |f|
      expect(page.source).to include("$templateCache.put(\"#{f}")
    end
  end
end

describe "asset rendering", :type => :feature, :js => true do
  before do
    @files = RailsTemplateCache.templates.values.map do |f|
      # Adding angular classes
      f.render.gsub(/(<[^\/]\w+)>/, '\1 class="ng-scope">')
    end
    visit '/'
  end

  it "adds templates to page" do
    @files.each do |f|
      expect(page.source).to include(f)
    end
  end
end
