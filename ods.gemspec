# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ods/version'

Gem::Specification.new do |spec|
  spec.name          = "ods"
  spec.version       = Ods::VERSION
  spec.authors       = ["Mike Park"]
  spec.email         = ["mikep@quake.net"]
  spec.description   = %q{Provides a command line and API interface to extract data from ods spreadsheets.}
  spec.summary       = %q{Gem to extract data from OpenOffice/LibreOffice .ods spreadsheets.}
  spec.homepage      = "https://github.com/mike-park/ods"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "nokogiri", "~> 1.6.0"
  spec.add_dependency "rubyzip", "~> 0.9.9"
  spec.add_dependency "thor"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 2.6"
  spec.add_development_dependency "awesome_print"
end
