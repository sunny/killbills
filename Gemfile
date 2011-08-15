source 'http://rubygems.org'

gem 'rails', :git => 'git://github.com/rails/rails.git', :tag => "v3.1.0.rc5"
gem 'devise'
# gem 'bj'
# gem 'nokogiri'
# gem 'aws-s3', :require => 'aws/s3'
# gem 'unicorn'
# gem 'capistrano'

# Assets
gem 'sass'
gem 'therubyracer-heroku'
gem 'coffee-script'
gem 'uglifier'
gem 'jquery-rails'

group :production do
  gem 'pg' # Required by Heroku
end

group :development, :test do
  gem 'sqlite3'

  # Tests
  gem 'shoulda'
  gem 'factory_girl_rails'
  gem 'ruby-prof'
  # gem 'webrat'
  # gem 'ruby-debug'
  # gem 'ruby-debug19', :require => 'ruby-debug'

  # Guard
  gem 'guard-test'
  gem 'guard-livereload'
  # gem 'rb-inotify' if RUBY_PLATFORM =~ /linux/
  # gem 'libnotify' if RUBY_PLATFORM =~ /linux/
end

