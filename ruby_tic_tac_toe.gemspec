$LOAD_PATH.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'ruby_tic_tac_toe/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'ruby_tic_tac_toe'
  s.version     = RubyTicTacToe::VERSION
  s.authors     = ['Louis Alridge']
  s.email       = ['loualrid@gmail.com']
  s.summary     = 'Play Tic Tac Toe in your terminal.'
  s.description = 'Play Tic Tac Toe in your terminal.'
  s.executables = %w(ruby_tic_tac_toe rttt ttt)

  s.files = Dir[
    '{app,config,db,lib}/**/*',
    'MIT-LICENSE',
    'Rakefile',
    'README.rdoc'
  ]

  s.test_files = Dir['spec/**/*']

  s.required_ruby_version = '>= 1.9.1'
  s.add_dependency 'terminal-table', '>= 1.7'
  s.add_dependency 'activesupport'

  s.add_development_dependency 'rspec', '>= 3.5.0'
  s.add_development_dependency 'rubocop', '>= 0.43.0'
end
