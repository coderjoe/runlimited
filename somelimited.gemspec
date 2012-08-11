# -*- encoding: utf-8 -*-
require File.expand_path('../lib/somelimited/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Joe Bauser"]
  gem.email         = ["coderjoe@coderjoe.net"]
  gem.description   = %q{A gem to rate limit blocks of Ruby code}
  gem.summary       = %q{TODO: Write a longer summary}
  gem.homepage      = "https://github.com/coderjoe/somelimited"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "somelimited"
  gem.require_paths = ["lib"]
  gem.version       = Somelimited::VERSION

	gem.add_development_dependency 'rake'
	gem.add_development_dependency 'minitest'
	gem.add_development_dependency 'minitest-wscolor'
	gem.add_development_dependency 'guard-minitest'
end
