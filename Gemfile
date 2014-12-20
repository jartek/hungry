source 'https://rubygems.org'

gem 'rails-api'

gem "active_model_serializers"
gem "rack-cors", require: "rack/cors"

gem 'pg'
gem 'unicorn'
gem 'kaminari'

gem 'devise_token_auth', github: 'jartek/devise_token_auth', branch: 'exclude_devise_modules'
gem 'omniauth'

group :development do
  gem 'spring-commands-rspec', require: false
  gem 'guard-bundler', require: false
  gem 'guard-rspec', require: false
  gem 'mina', require: false
  gem 'mina-unicorn', require: false
end

group :development, :test do
  gem 'rspec-rails', '~> 3.0'
  gem 'airborne'
end
