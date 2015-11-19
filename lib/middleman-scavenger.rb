# Require core library
require "middleman-core"

# Extension namespace
class MiddlemanScavenger < ::Middleman::Extension
  option :path, "./source/images/svg", "Directory containing SVG files"
  option :prefix, "", "Optional prefix for icon names"
  option :sprite_path, "sprite.svg", "Static file to write svg spritesheet to"

  def initialize(app, options_hash={}, &block)
    super

    require "svg_processor"

    processor_instance = SVGProcessor.new(options.path, options.prefix, options.sprite_path)
    processor_instance.rebuild
    app.set :svg_processor, processor_instance
    app.set :svg_sprite_path, options.sprite_path

    app.ready do
      files.changed do |file|
        if File.extname(file) == ".svg"
          svg_processor.rebuild
        end
      end

      files.deleted do |file|
        if File.extname(file) == ".svg"
          svg_processor.rebuild
        end
      end
    end
  end

  helpers do
    def scavenger_sprite_path
      image_path svg_sprite_path
    end

    def inline_svg_sprite
      "<svg style=\"display:none;\">#{svg_processor.to_s}</svg>"
    end

    def svg(name, options=nil)
      if defined?(options)
        attrs = options.map {|k,v| "#{k}=\"#{v}\"" }.join(" ")
        "<svg #{attrs}><use xlink:href=\"##{name}\" /></svg>"
      else
        "<svg><use xlink:href=\"##{name}\" /></svg>"
      end
    end
  end
end

# Register extensions which can be activated
# Make sure we have the version of Middleman we expect
# Name param may be omited, it will default to underscored
# version of class name

MiddlemanScavenger.register(:middleman_scavenger)
