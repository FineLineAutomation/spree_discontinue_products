# encoding: UTF-8
Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_distcontinue_products'
  s.version     = '1.3.1'
  s.summary     = 'A spree extension that adds is sold and discontinue options to products.'
  s.description = 'A spree extension that adds is sold and discontinue options to products. Allows a user to specify whether a product should be sold and whether a product should be discontinued.'
  s.required_ruby_version = '>= 1.8.7'

  # s.author    = 'Nathan Lowrie'
  # s.email     = 'nate@finelineautomation.com'
  # s.homepage  = 'http://www.finelineautomation.com'

  #s.files       = `git ls-files`.split("\n")
  #s.test_files  = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_path = 'lib'
  s.requirements << 'none'

  s.add_dependency 'spree_core', '~> 1.3.1'

  s.add_development_dependency 'capybara', '~> 1.1.2'
  s.add_development_dependency 'coffee-rails'
  s.add_development_dependency 'factory_girl', '~> 2.6.4'
  s.add_development_dependency 'ffaker'
  s.add_development_dependency 'rspec-rails',  '~> 2.9'
  s.add_development_dependency 'sass-rails'
  s.add_development_dependency 'sqlite3'
end
