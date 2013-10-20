# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'discover/version'

Gem::Specification.new do |gem|
  gem.name          = 'discover'
  gem.version       = Discover::VERSION
  gem.authors       = ['Bogdan Gusiev']
  gem.email         = ['agresso@gmail.com']
  gem.description   = %q{rspec matcher to test named scopes}
  gem.summary       = %q{extracted from accept_values_for gem}
  gem.homepage      = 'http://github.com/bogdan/discover'

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']

  if gem.respond_to? :specification_version
    gem.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0')
      gem.add_runtime_dependency(%q<activemodel>, ['>= 3.0.0'])
      gem.add_runtime_dependency(%q<rspec>, ['>= 0'])
      gem.add_development_dependency(%q<activerecord>, ['>= 3.0.0'])
      gem.add_development_dependency(%q<rspec-rails>, ['>= 2.0.0'])
      gem.add_development_dependency(%q<sqlite3-ruby>, ['>= 0'])
      gem.add_development_dependency(%q<jeweler>, ['>= 0'])
    else
      gem.add_dependency(%q<activemodel>, ['>= 3.0.0'])
      gem.add_dependency(%q<rspec>, ['>= 0'])
      gem.add_dependency(%q<activerecord>, ['>= 3.0.0'])
      gem.add_dependency(%q<rspec-rails>, ['>= 2.0.0'])
      gem.add_dependency(%q<sqlite3-ruby>, ['>= 0'])
    end
  else
    gem.add_dependency(%q<activemodel>, ['>= 3.0.0'])
    gem.add_dependency(%q<rspec>, ['>= 0'])
    gem.add_dependency(%q<activerecord>, ['>= 3.0.0'])
    gem.add_dependency(%q<rspec-rails>, ['>= 2.0.0'])
    gem.add_dependency(%q<sqlite3-ruby>, ['>= 0'])
  end
end
