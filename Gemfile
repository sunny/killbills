source 'http://rubygems.org'

# gem 'rails', '3.0.7'
gem 'rails', :git => 'git://github.com/rails/rails.git', :tag => "v3.1.0.rc3"

gem 'devise'
gem 'sass'
gem 'coffee-script'
gem 'uglifier'
gem 'jquery-rails'
# gem 'bj'
# gem 'nokogiri'
# gem 'aws-s3', :require => 'aws/s3'

gem 'sqlite3'
# gem 'unicorn'
# gem 'capistrano'

group :production do
  # Gems required by Heroku
  gem 'pg'
  gem 'therubyracer-heroku'
end

group :development, :test do
  gem 'shoulda'
  gem 'guard-test'
  gem 'guard-livereload'
  #gem 'rb-inotify' if RUBY_PLATFORM =~ /linux/
  #gem 'libnotify' if RUBY_PLATFORM =~ /linux/
  gem 'factory_girl_rails'
  # gem 'webrat'
  # gem 'ruby-debug'
  # gem 'ruby-debug19', :require => 'ruby-debug'
end

