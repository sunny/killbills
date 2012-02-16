source 'http://rubygems.org'

gem 'rails', '3.2.1'
gem 'devise'
gem 'jquery-rails'
gem 'activeadmin'

# Assets
gem 'sass-rails', '~> 3.2.3'
gem 'therubyracer-heroku'
gem 'coffee-rails', '~> 3.2.1'
gem 'uglifier', '= 1.0.3'

group :production do
  gem 'pg' # Required by Heroku
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


group :linux do
  gem 'libnotify'
end

