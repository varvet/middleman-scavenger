# Require core library
require 'middleman-core'

# Extension namespace
class MiddlemanScavenger < ::Middleman::Extension
  expose_to_template :sprite_sheet_string
  expose_to_template :external_sprite_path

  option :path, "./source/images/svg", "Directory containing SVG files"
  option :prefix, "", "Optional prefix for icon names"
  option :sprite_path, "images/sprite.svg", "Static file to write svg spritesheet to"

  def initialize(app, options_hash={}, &block)
    # Call super to build options from the options_hash
    super

    # Require libraries only when activated
    require "middleman-scavenger/svg_processor"

    # We need to keep these around inside the class
    @path = options.path
    @prefix = options.prefix
    @sprite_path = options.sprite_path

    app.config[:svg_sprite_path] = options.sprite_path

    # Make extension accessible inside on_change closure
    middleman_scavenger = self

    app.ready do
      files.on_change :source do |files|
        middleman_scavenger.update if files.any? {|file| File.extname(file.relative_path) == ".svg" }
      end
    end

    update
  end

  def external_sprite_path
    @sprite_path
  end

  def internal_sprite_path
    File.expand_path ["source", @sprite_path].join("/")
  end

  def sprite_sheet_string
    SVGProcessor.new(@path, @prefix).to_s
  end

  def update
    sprite_sheet = sprite_sheet_string
    write_to_file(sprite_sheet) unless @sprite_path.nil?
  end

  def write_to_file(sprite_sheet)
    File.write(internal_sprite_path, "<svg xmlns=\"http://www.w3.org/2000/svg\">#{sprite_sheet}</svg>")
  end

  helpers do
    def scavenger_sprite_path
      image_path app.config[:svg_sprite_path]
    end

    def inline_svg_sprite
      "<svg style=\"display:none;\">#{sprite_sheet_string}</svg>"
    end

    def svg(name, options=nil)
      if options.nil?
        "<svg><use xlink:href=\"##{name}\" /></svg>"
      else
        attrs = options.map {|k,v| "#{k}=\"#{v}\"" }.join(" ")
        "<svg #{attrs}><use xlink:href=\"##{name}\" /></svg>"
      end
    end
  end
end
