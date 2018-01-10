# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'datewari/version'

Gem::Specification.new do |spec|
  spec.name          = "datewari"
  spec.version       = Datewari::VERSION
  spec.authors       = ["Yoshikazu Kaneta"]
  spec.email         = ["kaneta@sitebridge.co.jp"]
  spec.summary       = %q{An ActiveRecord extension to build date oriented pagination links}
  spec.description   = %q{An ActiveRecord extension to build date oriented pagination links such as monthly pages and weekly pages}
  spec.homepage      = "https://github.com/kanety/datewari"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "activerecord", ">= 5.0"
  spec.add_dependency "actionview", ">= 5.0"

  spec.add_development_dependency "rails", ">= 5.0"
  spec.add_development_dependency "mysql2"
  spec.add_development_dependency "pg"
  spec.add_development_dependency "rspec-rails"
  spec.add_development_dependency "rails-controller-testing"
  spec.add_development_dependency "simplecov"
  spec.add_development_dependency "pry-rails"
  spec.add_development_dependency "pry-byebug"
end
