# RailsTemplateCache

[![Gem Version](https://badge.fury.io/rb/rails-template-cache.svg)](http://badge.fury.io/rb/rails-template-cache)
[![Build Status](https://travis-ci.org/frmendes/rails-template-cache.svg)](https://travis-ci.org/frmendes/rails-template-cache)

RailsTemplateCache lets you add your templates to Angular's `$templateCache`, preventing your app from making a request everytime it needs to fetch a template.

It was inspired on [pitr](https://github.com/pitr)'s [angular-rails-templates](https://github.com/pitr/angular-rails-templates), which currently works with Sprockets 2. This version is Sprockets 2 and 3 compatible. It also has no known issues with the [sprockets-es6](https://github.com/TannerRogalsky/sprockets-es6) gem.


Usage
---

First add it to your Gemfile:

```ruby
gem "rails-template-cache"
```

You'll need to require `rails-template-cache` in your `application.js` file. Make sure you do it **before** requiring your app.

```javascript
//= require angular
//= require rails-template-cache/rails-template-cache
//= require ./app/app
//= require_tree ./app
```

Finally, add `rails-template-cache` as a dependency in your module.

```javascript
angular.module('myApp', ['rails-template-cache']);
```

You can now either refer to your templates via `templateUrl`:

```javascript
{
  // ...
  templateUrl: 'path/to/template.html',
  // ...
}
```

Or via `ng-include`.

```html
<div ng-include="'path/to/template.html'"></div>
```

Note that this path is based on the value provided in `config.rails_template_cache.templates_path` (see [configuration](#configuration)). **Always add `.html`to the file name**.

Template Generation
-----------

Currently, the templates are being generated according to the file extension and **only Tilt templates are supported**.

According to the file extension, the corresponding Tilt template will be used to generate an HTML file.

Here you can find a list of the generated files:


| Filename                 | Generated file           |
|--------------------------|--------------------------|
| templates/file.html.erb  | templates/file.html      |
| templates/file.slim      | templates/file.html      |
| more_templates/file.html | more_templates/file.html |


Multiple extensions (`file.html.slim.erb`) are not supported, as will generate a `.html` file.


### Namespacing and collisions

As you can see in the previous examples, you have to be careful with the names you give to your files, since both a `file.slim` and a `file.html.erb` will generate a `file.html` and one of them will be overridden.

Unlike pitr's version, there is no danger in having a `templates/user.js` and a `templates/user.slim` file, since the second will be managed by RailsTemplateCache and not by Sprockets. However, this also means that when you add a new template, you have to restart your server (see the [issues section](#known-issues)).


Configuration
-------

There are a few configurations available for its behavior. Place your changes inside `config/application.rb`.

Default values:

```ruby
RailsTemplateCache.setup do |config|
  config.templates_path = File.join( ['app', 'assets', 'javascripts'] )
  config.extensions = %w(erb haml html slim)
  config.compress_html = false
end
```

### Templates Path

Defines the base path to where your templates will be placed.

Defaults to `app/assets/javascripts`.

**Example:** if you have your Angular app in `app/assets/javascripts/app` and don't change the default value, you will have to set `templateUrl: app/file.html`. If you change the value to `app/assets/javascripts/app`, setting `templateUrl: file.html` will do.

### Extensions

RailsTemplateCache looks for files with the given extensions inside the `templates_path`. You can define other extensions to look for, or even remove unused extensions. Right now, **only Tilt templates are supported**.

Defaults to `['erb', 'haml', 'html', 'slim']`.

### HTML Compressor

You can alter the `compress_html` option to allow the use of the [htmlcompressor](https://github.com/paolochiodi/htmlcompressor) gem. If you do this, add the following to your Gemfile:

```ruby
gem "htmlcompressor"
```

Defaults to `false`.

Note that the gem is still in active development and being ported, so beware of this use.


Known Issues
-------

### Need for a server restart after adding a new file

Right now, since RailsTemplateCache is responsible for managing the templates, instead of Sprockets, you have to restart your server if you add a new file. This is an issue that we are trying to address and a fix is in the [roadmap](#roadmap).



Roadmap
----

- [ ] Allow adding new templates without restarting the server.
- [ ] Allow non-Tilt, custom templates.
- [ ] Allow `htmlcompressor` options.

