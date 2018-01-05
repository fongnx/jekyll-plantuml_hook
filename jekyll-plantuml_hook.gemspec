
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
end
