# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cardconnect_sdk/version'

Gem::Specification.new do |spec|
  spec.name          = 'cardconnect_sdk'
  spec.version       = CardconnectSdk::VERSION
  spec.authors       = ['Chris Blackburn', 'Jason Cartwright']
  spec.email         = ['chris@midwiretech.com', 'jason@ensightenterprises.com']
  spec.summary       = 'A Ruby SDK for Card Connect payment services'
  spec.description   = spec.summary
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(/^bin\//) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(/^(test|spec|features)\//)
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'dotenv', '~> 1.0'
  spec.add_runtime_dependency 'rest-client'

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.1'
  spec.add_development_dependency 'factory_girl', '~> 4.5'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'guard'
  spec.add_development_dependency 'guard-rspec'
  spec.add_development_dependency 'guard-rubocop'
  spec.add_development_dependency 'guard-bundler'
  spec.add_development_dependency 'simplecov'
end
