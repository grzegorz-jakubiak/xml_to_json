source 'https://rubygems.org'

git_source(:github) { |repo_name| "https://github.com/#{repo_name}" }

# Specify your gem's dependencies in xtj.gemspec
gemspec

gem 'rake', '~> 12.3'

group :lint do
  gem 'rubocop', '~> 0.88.0', require: false
end
