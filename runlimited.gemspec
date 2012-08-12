# -*- encoding: utf-8 -*-
require File.expand_path('../lib/runlimited/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Joe Bauser"]
  gem.email         = ["coderjoe@coderjoe.net"]
  gem.description   = %q{Rate limit Ruby code execution}
  gem.summary       = %q{Make sure that your code runs only as fast as you allow it to}
  gem.homepage      = "https://github.com/coderjoe/runlimited"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "runlimited"
  gem.require_paths = ["lib"]
  gem.version       = Runlimited::VERSION

	gem.add_dependency 'redis'
	gem.add_dependency 'redis-namespace'

	gem.add_development_dependency 'rake'
	gem.add_development_dependency 'minitest'
	gem.add_development_dependency 'minitest-wscolor'
	gem.add_development_dependency 'guard-minitest'
	gem.add_development_dependency 'mock_redis'
	gem.add_development_dependency 'timecop'
end
