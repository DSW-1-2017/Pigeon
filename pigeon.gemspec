Gem::Specification.new do |s|
  s.name        = 'pigeon'
  s.version     = '0.0.1'
  s.date        = '2017-06-23'
  s.summary     = 'Pigeon'
  s.description = 'A gem for simplify communication between ruby applications'
  s.authors     = ['Wesley Araujo', 'Vinicius Pinheiro', 'Luan Guimarães', 'Victor Arnaud', 'Alexandre K.', 'Henrique Lopes']
  s.email       = 'wparaujo7@gmail.com'
  s.files       = Dir['lib/**/*.rb']
  s.license = 'MIT'
  s.add_dependency 'bunny', '~> 2.7', '>= 2.7.0'
  # spec.add_development_dependency 'rspec'
end
