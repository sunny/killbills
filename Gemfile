source 'http://rubygems.org'

gem 'rails', '3.2.1'
gem 'activeadmin', '0.4.1'
gem 'devise'
gem 'slim'

# Assets
gem 'sass-rails', '~> 3.2.3'
gem 'bootstrap-sass', '~> 2.0.2'
gem 'jquery-rails'
gem 'uglifier', '= 1.0.3'
gem 'coffee-rails', '~> 3.2.1'

group :production do
  # Required by Heroku
  gem 'pg'
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

  # Maintenance
  gem 'heroku'
  gem 'taps'
end


group :linux do
  gem 'libnotify'
end

