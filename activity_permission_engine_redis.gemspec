# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "activity_permission_engine_redis/version"

Gem::Specification.new do |spec|
  spec.name          = "activity_permission_engine_redis"
  spec.version       = ActivityPermissionEngineRedis::VERSION
  spec.authors       = ["Cedric Brancourt", "Synbioz"]
  spec.email         = ["cedric.brancourt@gmail.com", "oss@synbioz.com"]
  spec.summary       = %q{Redis adapter for the activity permission engine gem.}
  spec.description   = %q{ see https://github.com/synbioz/activity_permission_engine }
  spec.homepage      = "https://github.com/synbioz/activity_permission_engine_redis"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]


  spec.add_dependency "activity_permission_engine", "~> 0.0.1"
  spec.add_dependency "redis", "~> 3.2"

  spec.add_development_dependency "minitest", "~> 5.8"
  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
