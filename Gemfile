source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.1'

gem 'active_model_serializers', '~> 0.10.12'
gem 'rack-cors'
gem 'rails', '~> 6.1.3', '>= 6.1.3.1'
gem 'puma', '~> 5.0'
gem 'pg', '~> 1.1'
gem 'devise'
gem 'devise-jwt'
gem 'bootsnap', '>= 1.4.4', require: false
gem 'redis-namespace'
gem 'redis-rails'
gem 'idempotent-request', git: 'https://github.com/sandromileno/idempotent-request.git'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails', '~> 5.0.0'
  gem "factory_bot_rails"
end

group :development do
  gem 'listen', '~> 3.3'
  gem 'sqlite3', '~> 1.4'
  gem 'spring'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
