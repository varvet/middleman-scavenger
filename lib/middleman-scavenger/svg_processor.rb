class SVGProcessor
  require "middleman-core/logger"
  require "nokogiri"

  def initialize(path, prefix)
    @path = path
    @prefix = prefix
    build
  end

  def build
    svgs = Dir["#{@path}/*.svg"].map { |file| get_svg(file) }
    logger.info "Middleman-Scavenger rebuilding: #{svgs.length} svgs found"
    symbols = svgs.map { |svg| convert_to_symbol(svg) }

    @symbol_string = symbols.join("\n")
  end

  def to_s
    @symbol_string
  end

  private

  def logger
    ::Middleman::Logger.singleton(1)
  end

  def get_svg(file)
    f = File.open(file)
    doc = Nokogiri::XML(f)
    f.close

    {
      filename: File.basename(file, ".svg"),
      xml: doc
    }
  end

  def convert_to_symbol(svg)
    svg[:xml].xpath('//@id').remove
    content = svg[:xml].at_css("svg").children
    viewbox_size = svg[:xml].xpath("//@viewBox").first.value
    "<symbol viewBox=\"#{viewbox_size}\" id=\"#{@prefix}#{svg[:filename]}\">#{content.to_s.strip}</symbol>"
  end
end
