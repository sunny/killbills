source 'http://rubygems.org'

gem 'rails', '3.1.0'
gem 'devise'
gem 'jquery-rails'

group :production do
  gem 'pg' # Required by Heroku
end

# SASS and CoffeeScript through the asset pipeline
# Can be ignored in production if pre-compiling assets
group :assets do
  gem 'sass'
  gem 'therubyracer-heroku'
  gem 'coffee-script'
  gem 'uglifier'
end

group :development, :test do
  gem 'sqlite3'

  # Tests
  gem 'shoulda'
  gem 'factory_girl_rails'
  gem 'ruby-prof'

  # Guard
  gem 'guard-test'
  gem 'guard-livereload'
end

