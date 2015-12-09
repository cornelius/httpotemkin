require File.expand_path("../lib/version", __FILE__)

Gem::Specification.new do |s|
  s.name        = 'httpotemkin'
  s.version     = Httpotemkin::VERSION
  s.license     = 'MIT'
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Cornelius Schumacher']
  s.email       = ['schumacher@kde.org']
  s.homepage    = 'https://github.com/cornelius/httpotemkin'
  s.summary     = 'Mock HTTP services for system tests'
  s.description = 'Httpotemkin provides tools to mock HTTP servers for system-level tests.'
  s.required_rubygems_version = '>= 1.3.6'
  s.rubyforge_project         = 'httpotemkin'

  s.add_development_dependency 'rspec', '~> 3.0'
  s.add_development_dependency 'given_filesystem', '>= 0.1.2'
  s.add_development_dependency 'cli_tester', '>= 0.0.2'

  s.add_runtime_dependency 'terminal-table', '~> 1.5'

  s.files        = `git ls-files`.split("\n")
  s.require_path = 'lib'
  s.executables = ["httpotemkin"]
end
