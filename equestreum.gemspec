lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'equestreum/version'

Gem::Specification.new do |spec|
  spec.name          = 'equestreum'
  spec.version       = Equestreum::VERSION
  spec.authors       = ['pikesley']
  spec.email         = ['sam.pikesley@gmail.com']

  spec.summary       = %q{Let's build a blockchain}
  spec.description   = %q{For the Voting Machine}
  spec.homepage      = 'http://pikesley.org'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'timecop', '~> 0.9'
end
