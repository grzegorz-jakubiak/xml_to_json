lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'xtj/version'

Gem::Specification.new do |spec|
  spec.name          = 'xtj'
  spec.version       = XTJ::VERSION
  spec.authors       = ['Grzegorz Jakubiak']
  spec.email         = ['grzegorz.jakubiak@outlook.com']

  spec.summary       = 'Allows you to parse XML documents into Ruby Hash or JSON'
  spec.description   = spec.summary
  spec.homepage      = 'https://github.com/grzegorz-jakubiak/xtj'
  spec.license       = 'MIT'
  spec.required_ruby_version = '>=2.5'

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.17'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
end
