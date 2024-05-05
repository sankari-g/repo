# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.6'

gem 'activerecord-import'
gem 'parallel'
gem 'pg', '~> 1.4', '>= 1.4.3'
gem 'rails', '~> 6.1.0'

gem 'bootsnap'
gem 'brakeman'
gem 'coffee-rails', '~> 4.2'
gem 'jbuilder'
gem 'json'
gem 'kaminari'
gem 'listen'
gem 'puma', '~> 4.3'
gem 'turbolinks', '~> 5'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'pry-byebug'
  gem 'rubocop-rails', require: false
end

group :development do
  gem 'bullet'
  gem 'rack-mini-profiler'
  gem 'web-console'
end

group :test do
  gem 'rails-controller-testing'
  gem 'rspec'
  gem 'rspec-rails'
end
