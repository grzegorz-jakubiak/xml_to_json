source 'https://rubygems.org'

git_source(:github) { |repo_name| "https://github.com/#{repo_name}" }

# Specify your gem's dependencies in xtj.gemspec
gemspec

gem 'sorbet', :group => :development
gem 'sorbet-runtime'

group :lint do
  gem 'rubocop', '~> 0.74.0', require: false
end
