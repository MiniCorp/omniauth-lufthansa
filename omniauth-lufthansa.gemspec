# coding: utf-8
require File.expand_path(File.join('..', 'lib', 'omniauth', 'lufthansa', 'version'), __FILE__)

Gem::Specification.new do |s|
  s.name = "omniauth-lufthansa"
  s.version = OmniAuth::Lufthansa::VERSION

  s.authors = ["Steve Thornton"]
  s.date = "2018-03-15"
  s.description = "Lufthansa Omniauth Strategy"
  s.email = "steve@minicorp.com"
  # s.extra_rdoc_files = [
  #   "LICENSE.txt",
  #   "README.md"
  # ]
  s.homepage = "http://github.com/minicorp/omniauth-lufthansa"
  s.licenses = ["MIT"]
  # s.rubygems_version = "0.1"
  s.summary = "Implementation of an Omniauth Strategy to integrate with the Lufthansa OAuth API."

  s.files         = `git ls-files`.split($/)
  s.executables   = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ["lib"]

  s.add_runtime_dependency 'jwt', '~> 1.5'
  s.add_runtime_dependency 'omniauth-oauth2', '~> 1.6'
end
