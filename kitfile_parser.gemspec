# -*- encoding: utf-8 -*-
require File.expand_path("../lib/kitfile_parser/version", __FILE__)

Gem::Specification.new do |s|
  s.name        = "kitfile_parser"
  s.version     = KitfileParser::VERSION
  s.authors     = ["Andy Rossmeissl", "Seamus Abshere"]
  s.email       = "andy@rossmeissl.net"
  s.homepage    = "https://github.com/bitkit/kitfile_parser"
  s.summary     = %Q{A Ruby parser for the Kitfile format}
  s.description = %Q{Parse Kitfiles}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  
  s.add_development_dependency 'minitest'
  s.add_development_dependency 'minitest-reporters'
  s.add_development_dependency 'bueller'
  s.add_development_dependency 'fakefs'
  s.add_dependency 'yard'
end
