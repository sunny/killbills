ruby '1.9.3'
source 'http://rubygems.org'

gem 'rails', '~> 3.2.11'
gem 'pg'
gem 'activeadmin'
gem 'enumerize'
gem 'devise'
gem 'devise_browserid_authenticatable', '~> 1.2.0'
gem 'haml'
gem 'dalli'
gem 'thin'
gem 'exception_notification'
gem 'draper'


# Rails 4
gem 'strong_parameters'
gem 'turbolinks'
gem 'cache_digests'

# Asset libraries needed in production
gem 'jquery-rails-cdn'

# Asset libraries not needed in production
group :assets do
  # CSS
  gem 'sass-rails'
  gem 'compass-rails'
  gem 'bootstrap-sass'
  gem 'yui-compressor'

  # JS
  gem 'uglifier'
  gem 'coffee-rails'
  gem 'jquery-turbolinks'
  gem 'rails-backbone'
  gem 'eco'
  gem 'i18n-js'
end

group :development do
  # Debugging
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'meta_request'
  # gem 'rack-mini-profiler'
  # gem 'bullet'
  # gem 'debugger'
  # gem 'xray-rails'

  # Guard
  gem 'guard-test'
  gem 'guard-livereload'
  gem 'guard-pow'
end

group :test do
  gem 'shoulda-context'
  gem 'shoulda-matchers'
  gem 'factory_girl_rails'
  gem 'mocha', require: false
end
