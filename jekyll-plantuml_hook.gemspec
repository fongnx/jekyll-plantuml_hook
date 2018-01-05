
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'jekyll/plantuml_hook/version'

Gem::Specification.new do |spec|
  spec.name          = 'jekyll-plantuml_hook'
  spec.version       = Jekyll::PlantumlHook::VERSION
  spec.authors       = ['Chulki Lee']
  spec.email         = ['chulki.lee@gmail.com']

  spec.summary       = 'Render plantuml'
  spec.homepage      = 'https://github.com/chulkilee/jekyll-plantuml_hook'
  spec.license       = 'MIT'

  spec.files         = Dir['lib/**/*']
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'minitest', '~> 5.0'
  spec.add_development_dependency 'rake', '~> 10.0'
end
