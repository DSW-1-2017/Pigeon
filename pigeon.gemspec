Gem::Specification.new do |s|
  s.name        = 'pigeon'
  s.version     = '0.0.0'
  s.date        = '2017-06-23'
  s.summary     = 'Hola!'
  s.description = 'A gem for simplify communication between ruby applications'
  s.authors     = ['Wesley Araujo', 'Vinicius Pinheiro']
  s.email       = 'wparaujo7@gmail.com'
  s.files       = ['lib/pigeon.rb']
  s.license = 'MIT'
  s.add_dependency 'bunny', '~> 2.7'
  # spec.add_development_dependency 'rspec'
end
