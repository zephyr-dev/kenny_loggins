# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'kenny_loggins/version'

Gem::Specification.new do |spec|
  spec.name          = "kenny_loggins"
  spec.version       = KennyLoggins::VERSION
  spec.authors       = ["Gust"]
  spec.email         = ["zephyr-dev@googlegroups.com"]
  spec.summary       = %q{Logging service}
  spec.description   = %q{It's a full blown footloose dangerzone}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(spec|features)/})
  spec.require_paths = ["config", "lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
