Gem::Specification.new do |s|
  s.name        = 'floripa-public-transit'
  s.version     = '0.0.1'
  s.date        = '2014-04-14'
  s.summary     = 'Fetches public transit information from the Florianopolis city website'
  s.authors     = ['Paulo Ragonha', 'Felipe Munhoz']
  s.email       = ['paulo@ragonha.me', 'munhoz@gmail.com']

  s.files       = `git ls-files`.split("\n")
  s.test_files  = `git ls-files -- spec`.split("\n")
  s.require_paths = ['lib']

  s.homepage    = 'https://github.com/floripa-mobi/floripa-public-transit'
  s.license     = 'MIT'

  s.add_runtime_dependency 'nokogiri', '1.6.1'
  s.add_development_dependency 'rspec'
end
