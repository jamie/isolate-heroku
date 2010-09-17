Gem::Specification.new do |s|
  s.name = 'isolate-heroku'
  s.version = '1.0'
  s.platform = Gem::Platform::RUBY
  s.authors = ['Jamie Macey']
  s.email = ['jamie.ruby@tracefunc.com']
  s.homepage = 'http://github.com/jamie/isolate-heroku'
  s.summary = 'Automatically regenerate .gems file for Heroku from Isolate sandbox'
  s.description = 'Automatically keeps your .gems file up to date any time you change your Isolated dependencies and run the application locally'

  s.required_rubygems_version = '>= 1.3.6'

  s.add_dependency 'isolate'
  s.files = %w(lib/isolate/heroku.rb LICENSE README)
  s.require_path = 'lib'
end
