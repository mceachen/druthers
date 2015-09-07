# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'druthers/version'

Gem::Specification.new do |spec|
  spec.name = 'druthers'
  spec.version = Druthers::VERSION
  spec.authors = ["Matthew McEachen"]
  spec.email = ["matthew+github@mceachen.org"]
  spec.description = %q{Simple, performant settings for your Rails application}
  spec.summary = ''
  spec.homepage = 'https://github.com/mceachen/druthers'
  spec.license = 'MIT'

  spec.files = `git ls-files`.split($/)
  spec.executables = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = %w(lib)

  spec.add_dependency 'activerecord', '>= 4.2'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'yard'
  spec.add_development_dependency 'mysql2'
  spec.add_development_dependency 'pg'
  spec.add_development_dependency 'sqlite3'
  spec.add_development_dependency 'minitest-great_expectations'
  spec.add_development_dependency 'minitest-reporters' unless ENV['CI']
end
