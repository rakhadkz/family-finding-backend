source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.0'


gem 'rails', '~> 6.0.3', '>= 6.0.3.4'
gem 'puma', '~> 4.1'
gem 'pg'
gem 'jwt'
gem 'blueprinter'
gem 'rollbar'
gem 'devise'
gem 'dotenv-rails'
gem 'kaminari'
gem 'nokogiri'
gem 'pg_search'
gem 'rack-cors'
gem 'bootsnap', '>= 1.4.2', require: false
gem 'sendgrid-ruby'
gem 'pry', '~> 0.13.1'
gem 'twilio-ruby'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem 'listen', '~> 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'rspec-rails'
  gem 'vcr'
  gem 'webmock'
end

group :development, :production do
  gem 'http_logger'
end