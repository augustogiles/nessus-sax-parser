# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'nessus_sax_parser/version'

Gem::Specification.new do |spec|
  spec.name          = "nessus_sax_parser"
  spec.version       = "0.1.0"
  spec.authors       = ["Augusto Costa"]
  spec.email         = [""]

  spec.summary       = %q{Nokogiri SAX Parser for XML Nessus File}
  spec.description   = %q{This parser support only 2.0 of .nessus file format.}
  # spec.homepage      = ""
  spec.license       = "MIT"
  spec.files = ['lib/nessus_sax_parser.rb']

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  # if spec.respond_to?(:metadata)
    # spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  # else
    # raise "RubyGems 2.0 or newer is required to protect against " \
      # "public gem pushes."
  # end

  # spec.files         = `git ls-files -z`.split("\x0").reject do |f|
  #   f.match(%r{^(test)/})
  # end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib", "lib/nessus_sax_parser/version"]

  spec.add_development_dependency "nokogiri", "~> 1.7"
  end
