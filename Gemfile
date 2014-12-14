source 'https://rubygems.org'

gem 'rails-api'

gem "active_model_serializers"
gem "rack-cors", require: "rack/cors"

gem 'pg'
gem 'unicorn'
gem 'kaminari'

gem 'devise_token_auth', path: '../devise_token_auth/'
gem 'omniauth'

group :development do
  gem 'spring'
  gem 'better_errors', '~> 2.0.0'
  gem "binding_of_caller"
  gem 'mina'
  gem 'mina-unicorn', :require => false
end

group :development, :test do
  gem 'rspec-rails', '~> 3.0'
end
