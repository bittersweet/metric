# -*- encoding: utf-8 -*-
require File.expand_path('../lib/metric/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Mark Mulder"]
  gem.email         = ["markmulder@gmail.com"]
  gem.description   = "Track metrics via metric.io"
  gem.summary       = "Companion gem to the metric.io site to track metrics"
  gem.homepage      = 'http://github.com/bittersweet/metric'

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "metric"
  gem.require_paths = ['lib']
  gem.version       = Metric::VERSION

  gem.add_runtime_dependency 'faraday'

  # Tests
  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'webmock'
end

