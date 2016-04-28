# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "middleman-scavenger"
  s.version     = "1.0.2"
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Johan Halse"]
  s.email       = ["johan.halse@varvet.com"]
  s.license     = "MIT"
  s.homepage    = "https://github.com/varvet/middleman-scavenger"
  s.summary     = %q{A middleman extension for automatically creating SVG sprite sheets}
  s.description = %q{Discovers and compiles SVG files into a sprite sheet that can be used for icons and such.}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # The version of middleman-core your extension depends on
  s.add_runtime_dependency("middleman-core", [">= 3.3.1", "< 4.0.0"])

  # Additional dependencies
  s.add_runtime_dependency("nokogiri", "~> 1.6")
end
