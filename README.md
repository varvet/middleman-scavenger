# Middleman-scavenger

[![Gem Version](http://img.shields.io/gem/v/middleman-scavenger.svg)](https://rubygems.org/gems/middleman-scavenger) [![Code Climate](https://codeclimate.com/github/varvet/middleman-scavenger/badges/gpa.svg)](https://codeclimate.com/github/varvet/middleman-scavenger) [![Build Status](https://travis-ci.org/varvet/middleman-scavenger.svg?branch=master)](https://travis-ci.org/varvet/middleman-scavenger)

A Middleman extension for creating svg sprite sheets. It's usable in modern (IE9+) browsers, uses `<symbol>` to include the svg:s, and can optionally inline the SVG images for speed. If you need legacy browser support it combines well with [svg4everybody](https://github.com/jonathantneal/svg4everybody).

## Important info about older and newer middleman versions!

A bunch of things have happened in Middleman core since this plugin was created. There were some changes between minor versions in Middleman 3.x in regard to how files are resolved. This created some unfortunate incompatibilities in middleman-scavenger and to simplify things, the master branch of middleman-scavenger is only compatible with 3.4.x. Middleman 4 has thrown out the Sprockets asset pipeline completely, which is... interesting for us. So, in short:

- If you're using Middleman 3.4.x, just include everything as usual
- If you're on Middleman 3.3.x (or maybe earlier?) you should lock your version of `middleman-scavenger` to 1.0.2
- If you've upgraded to Middleman 4, hold on while we figure things out and use [This branch](https://github.com/varvet/middleman-scavenger/tree/feature/middleman-4-support) in the meantime, as documented [here](https://github.com/varvet/middleman-scavenger/pull/11).

## Installation and quick start

- Put the SVG:s you want to include in `source/images/svg`.
- Add `gem "middleman-scavenger"` to your gemfile and run `bundle install`
- Add `activate :middleman_scavenger` to your config.rb file
- Add `//= require middleman-scavenger` to your all.js file

Done! Now you can include your SVG images with the `svg` helper:
```ruby
  <%= svg "my-image", class: "my-image-class" %>
```


## Configuration

If you don't like the default settings, you can change them at activation time. These are the three available configuration directives:

```ruby
  activate :middleman_scavenger do |config|
    config.path = "./source/my-svg-directory/"
    config.prefix = "icon-"
    config.sprite_path = "source/javascripts/my-sprite.svg"
  end
```

- `path` sets the directory where Middleman-scavenger looks for SVG files. Every time an SVG is added, removed, or changed, Middleman-scavenger will rebuild a sprite sheet from all the files it finds there
- `prefix` sets an optional prefix for symbol ids. By default, when Middleman-scavenger finds an svg called `my-svg.svg` it will set the symbol id to the filename, so you can do `<%= svg "my-svg" %>`. If you prefer, you can set a prefix to use something like `<%= svg "icon-my-svg" %>` instead
- `sprite_path` will change the path and filename for the static file that Middleman-scavenger writes to disk.

## Helpers

### Displaying images from the sprite

Use `<%= svg "my-image" %>` to display an image from the sprite. Middleman-scavenger will insert an `svg` element for you that references an image inside the sprite sheet. You can append HTML attributes to that SVG element with an options hash, like this: `<%= svg "my-image", class: "my-image-class", width: 200, height: 100 %>`.

### Inlining

If you include the JS file, Middleman-scavenger will XHR load the sprite sheet and insert it into the DOM. If you prefer to inline the SVG document instead of loading it asynchronously, don't add the javascript file and use the `<%= inline_svg_sprite %>` helper instead. It will insert a hidden SVG, then you can use the `<%= svg %>` helper as usual.


### Sprite path

If you want to reference the sprite directly, you can use `scavenger_sprite_path`. It uses the built-in asset_path helper and is safe even when the `asset_hash` directive is activated.


## How it works

Middleman-scavenger uses an SVG processor based on [Nokogiri](http://www.nokogiri.org) to load and parse the SVG images in the folder into a sprite sheet, each image in its own `<symbol>` with its own viewBox. The sprite sheet is cached in memory and written to disk, so it can be asynchronously loaded or quickly inlined into the document. Whenever an SVG is added, removed, or changed in development mode Middleman-scavenger will make a new in-memory and on-disk version. The rebuild process fires at build time as well.

The bundled javascript will asynchronously load the SVG sprite sheet as text and insert it at the top of the body. This makes it possible to control the SVG sprites via CSS. An externally referenced SVG will create a shadow DOM boundary that is impossible to cross, but inserting the sprite sheet into the document removes that obstacle and makes it possible to control transitions and hover states.


## Gotchas

### Sizing

SVG sizing is always a little difficult, and even more so with sprite sheets. Middleman-scavenger allows each image to have its own viewBox, which means they will scale as expected when given width or height parameters. Including an SVG without sizing information will constrain it to the dimensions of the element it was included in, so it's advisable to add `width:` or `height:` or a styled CSS selector to the `svg` helper.


### FONI

Since default behavior is to asynchronously load the sprite sheet, you may experience a "flash of no images" while the script is fetching your SVGs. Depending on your application, this may or may not be acceptable. The solution is to inline the sprite as described under the "Inlining" section above, but beware - if you have a lot of SVG:s it will bloat the size of each page since the inlined sprite sheet won't be cached between pages.


## Who made this?

I'm [Johan Halse](https://www.twitter.com/hejsna) and I work at [Varvet](https://www.varvet.se). We do Ruby and Javascript and we're super friendly. You should totally hire us!

## License
[MIT](http://johanhalse.mit-license.org)
