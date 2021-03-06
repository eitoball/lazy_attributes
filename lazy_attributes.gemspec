# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "lazy_attributes"
  spec.version       = '0.0.4'
  spec.authors       = ["Eito Katagiri"]
  spec.email         = ["eitoball@gmail.com"]
  spec.summary       = %q{ActiveRecord plugin to load specified attributes lazyly}
  spec.description   = %q{ActiveRecord plugin to load specified attributes lazyly}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'activerecord', '>= 3.2', '< 5'

  spec.add_development_dependency 'appraisal', '~> 1.0.0'
  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'database_cleaner'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  unless RUBY_PLATFORM == 'jruby'
    spec.add_development_dependency 'sqlite3'
  else
    spec.add_development_dependency 'jdbc-sqlite3'
  end
end
