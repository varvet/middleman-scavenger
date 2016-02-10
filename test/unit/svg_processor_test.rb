require_relative "test_helper"
require "middleman-scavenger"
require "middleman-scavenger/svg_processor"

class SvgProcessorTest < Minitest::Test
  def teardown
    File.delete("sprite.svg") if File.exist?("sprite.svg")
  end

  def test_adds_prefix
    str = "<symbol viewBox=\"0 0 34 22\" id=\"icon-basic-svg\"><path d=\"M33.7.9c0-.1-.1-.2-.1-.2s0-.1-.1-.1l-.1-.1-.2-.2-.2-.1-.2-.1c-.1 0-.2 0-.2-.1h-31.6c-.1 0-.2 0-.2.1l-.2.1-.2.2-.1.1s0 .1-.1.1l-.1.2c0 .1 0 .2-.1.3v18.8c0 .7.6 1.2 1.2 1.2h31.2c.7 0 1.2-.6 1.2-1.2v-18.8c.1-.1.1-.1.1-.2zm-4.9 1.6l-11.9 9.2-11.9-9.2h23.8zm-26.3 16.3v-14.9l13.6 10.5c.2.2.5.3.8.3.3 0 .5-.1.8-.3l13.6-10.5v14.9h-28.8z\"/></symbol>\n<symbol viewBox=\"0 0 270.477 284\" id=\"icon-illustrator-svg\"><g>\n  <path fill=\"#FFFFFF\" d=\"M135.238,0L0,81.143V284h270.477V81.143L135.238,0z M52.554,255.374H40.572v-27.969h11.982V255.374z      M52.554,223.41H40.572v-27.962h11.982V223.41z M52.554,191.453H40.572v-27.966h11.982V191.453z M52.554,159.492H40.572v-27.965     h11.982V159.492z M68.541,255.374H56.549v-27.969h11.992V255.374z M68.541,223.41H56.549v-27.962h11.992V223.41z M68.541,191.453     H56.549v-27.966h11.992V191.453z M68.541,159.492H56.549v-27.965h11.992V159.492z M84.521,255.374H72.536v-27.969h11.985V255.374z      M84.521,223.41H72.536v-27.962h11.985V223.41z M84.521,191.453H72.536v-27.966h11.985V191.453z M84.521,159.492H72.536v-27.965     h11.985V159.492z M100.498,255.374H88.516v-27.969h11.982V255.374z M100.498,223.41H88.516v-27.962h11.982V223.41z      M100.498,191.453H88.516v-27.966h11.982V191.453z M100.498,159.492H88.516v-27.965h11.982V159.492z M116.475,255.374h-11.982     v-27.969h11.982V255.374z M116.475,223.41h-11.982v-27.962h11.982V223.41z M116.475,191.453h-11.982v-27.966h11.982V191.453z      M116.475,159.492h-11.982v-27.965h11.982V159.492z M165.983,255.374h-11.981v-27.969h11.981V255.374z M165.983,223.41h-11.981     v-27.962h11.981V223.41z M165.983,191.453h-11.981v-27.966h11.981V191.453z M165.983,159.492h-11.981v-27.965h11.981V159.492z      M181.971,255.374h-11.992v-27.969h11.992V255.374z M181.971,223.41h-11.992v-27.962h11.992V223.41z M181.971,191.453h-11.992     v-27.966h11.992V191.453z M181.971,159.492h-11.992v-27.965h11.992V159.492z M197.951,255.374h-11.985v-27.969h11.985V255.374z      M197.951,223.41h-11.985v-27.962h11.985V223.41z M197.951,191.453h-11.985v-27.966h11.985V191.453z M197.951,159.492h-11.985     v-27.965h11.985V159.492z M213.928,255.374h-11.981v-27.969h11.981V255.374z M213.928,223.41h-11.981v-27.962h11.981V223.41z      M213.928,191.453h-11.981v-27.966h11.981V191.453z M213.928,159.492h-11.981v-27.965h11.981V159.492z M229.905,255.374h-11.982     v-27.969h11.982V255.374z M229.905,223.41h-11.982v-27.962h11.982V223.41z M229.905,191.453h-11.982v-27.966h11.982V191.453z      M229.905,159.492h-11.982v-27.965h11.982V159.492z\"/>\n</g></symbol>\n<symbol viewBox=\"0 0 29 29\" id=\"icon-sketch-svg\"><title>checkbox</title><g transform=\"translate(1 1)\" stroke=\"#FAB131\" fill=\"none\" fill-rule=\"evenodd\">\n  <ellipse fill=\"#FFF\" cx=\"13.519\" cy=\"13.522\" rx=\"13.434\" ry=\"13.257\"/>\n  <path d=\"M6.724 13.533l5.057 4.99 9.337-9.212\" stroke-width=\"2\"/>\n</g></symbol>"
    assert_equal str, SVGProcessor.new("test/svg", "icon-").to_s
  end

  def test_output_is_correct
    str = "<symbol viewBox=\"0 0 34 22\" id=\"basic-svg\"><path d=\"M33.7.9c0-.1-.1-.2-.1-.2s0-.1-.1-.1l-.1-.1-.2-.2-.2-.1-.2-.1c-.1 0-.2 0-.2-.1h-31.6c-.1 0-.2 0-.2.1l-.2.1-.2.2-.1.1s0 .1-.1.1l-.1.2c0 .1 0 .2-.1.3v18.8c0 .7.6 1.2 1.2 1.2h31.2c.7 0 1.2-.6 1.2-1.2v-18.8c.1-.1.1-.1.1-.2zm-4.9 1.6l-11.9 9.2-11.9-9.2h23.8zm-26.3 16.3v-14.9l13.6 10.5c.2.2.5.3.8.3.3 0 .5-.1.8-.3l13.6-10.5v14.9h-28.8z\"/></symbol>\n<symbol viewBox=\"0 0 270.477 284\" id=\"illustrator-svg\"><g>\n  <path fill=\"#FFFFFF\" d=\"M135.238,0L0,81.143V284h270.477V81.143L135.238,0z M52.554,255.374H40.572v-27.969h11.982V255.374z      M52.554,223.41H40.572v-27.962h11.982V223.41z M52.554,191.453H40.572v-27.966h11.982V191.453z M52.554,159.492H40.572v-27.965     h11.982V159.492z M68.541,255.374H56.549v-27.969h11.992V255.374z M68.541,223.41H56.549v-27.962h11.992V223.41z M68.541,191.453     H56.549v-27.966h11.992V191.453z M68.541,159.492H56.549v-27.965h11.992V159.492z M84.521,255.374H72.536v-27.969h11.985V255.374z      M84.521,223.41H72.536v-27.962h11.985V223.41z M84.521,191.453H72.536v-27.966h11.985V191.453z M84.521,159.492H72.536v-27.965     h11.985V159.492z M100.498,255.374H88.516v-27.969h11.982V255.374z M100.498,223.41H88.516v-27.962h11.982V223.41z      M100.498,191.453H88.516v-27.966h11.982V191.453z M100.498,159.492H88.516v-27.965h11.982V159.492z M116.475,255.374h-11.982     v-27.969h11.982V255.374z M116.475,223.41h-11.982v-27.962h11.982V223.41z M116.475,191.453h-11.982v-27.966h11.982V191.453z      M116.475,159.492h-11.982v-27.965h11.982V159.492z M165.983,255.374h-11.981v-27.969h11.981V255.374z M165.983,223.41h-11.981     v-27.962h11.981V223.41z M165.983,191.453h-11.981v-27.966h11.981V191.453z M165.983,159.492h-11.981v-27.965h11.981V159.492z      M181.971,255.374h-11.992v-27.969h11.992V255.374z M181.971,223.41h-11.992v-27.962h11.992V223.41z M181.971,191.453h-11.992     v-27.966h11.992V191.453z M181.971,159.492h-11.992v-27.965h11.992V159.492z M197.951,255.374h-11.985v-27.969h11.985V255.374z      M197.951,223.41h-11.985v-27.962h11.985V223.41z M197.951,191.453h-11.985v-27.966h11.985V191.453z M197.951,159.492h-11.985     v-27.965h11.985V159.492z M213.928,255.374h-11.981v-27.969h11.981V255.374z M213.928,223.41h-11.981v-27.962h11.981V223.41z      M213.928,191.453h-11.981v-27.966h11.981V191.453z M213.928,159.492h-11.981v-27.965h11.981V159.492z M229.905,255.374h-11.982     v-27.969h11.982V255.374z M229.905,223.41h-11.982v-27.962h11.982V223.41z M229.905,191.453h-11.982v-27.966h11.982V191.453z      M229.905,159.492h-11.982v-27.965h11.982V159.492z\"/>\n</g></symbol>\n<symbol viewBox=\"0 0 29 29\" id=\"sketch-svg\"><title>checkbox</title><g transform=\"translate(1 1)\" stroke=\"#FAB131\" fill=\"none\" fill-rule=\"evenodd\">\n  <ellipse fill=\"#FFF\" cx=\"13.519\" cy=\"13.522\" rx=\"13.434\" ry=\"13.257\"/>\n  <path d=\"M6.724 13.533l5.057 4.99 9.337-9.212\" stroke-width=\"2\"/>\n</g></symbol>"
    assert_equal str, SVGProcessor.new("test/svg", nil).to_s
  end
end
