# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ruby-pg-extras/version'

Gem::Specification.new do |gem|
  gem.name          = "ruby-pg-extras"
  gem.version       = RubyPGExtras::VERSION
  gem.authors       = ["pawurb"]
  gem.email         = ["contact@pawelurbanek.com"]
  gem.summary       = %q{ Ruby PostgreSQL performance database insights }
  gem.description   = %q{ Ruby port of Heroku PG Extras. The goal of this project is to provide a powerful insights into PostgreSQL database for Ruby on Rails apps that are not using the default Heroku PostgreSQL plugin. }
  gem.homepage      = "http://github.com/pawurb/ruby-pg-extras"
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = gem.files.grep(%r{^(spec)/})
  gem.require_paths = ["lib"]
  gem.license       = "MIT"
  gem.add_dependency "pg"
  gem.add_dependency "filesize"
  gem.add_dependency "terminal-table"
  gem.add_development_dependency "rake"
  gem.add_development_dependency "rspec"
end
