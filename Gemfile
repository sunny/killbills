source 'http://rubygems.org'

gem 'rails', '3.2.1'
gem 'devise'
gem 'jquery-rails'
gem 'activeadmin', '0.4.1'

# Assets
gem 'sass-rails', '~> 3.2.3'
gem 'coffee-rails', '~> 3.2.1'
gem 'uglifier', '= 1.0.3'

group :production do
  gem 'pg' # Required by Heroku
  gem 'therubyracer-heroku', platforms: :ruby
end

group :development, :test do
  gem 'therubyracer'
  gem 'sqlite3'

  # Tests
  gem 'shoulda-context'
  gem 'shoulda-matchers'
  gem 'factory_girl_rails'
  gem 'ruby-prof'

  # Guard
  gem 'guard-test'
  gem 'guard-livereload'
end


group :linux do
  gem 'libnotify'
end

