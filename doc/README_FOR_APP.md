Installing
==========

Development Setup
-----------------

### Postgresql

Install the postgres package for your system. For example on OSX with the brew package manager:

    $ brew install postgres

Follow install instructions.

Then, create the development database and user:

    $ createuser killbills
    $ createdb -Okillbills -Eutf8 killbills_development
    $ createdb -Okillbills -Eutf8 killbills_test

### Ruby 1.9.2

Install ruby 1.9.2 with rvm (`rvm install 1.9.2`) or rbenv.

Install bundler on this version of ruby.

    $ gem install bundler

### Download

    $ git clone https://github.com/sunny/killbills.git
    $ cd killbills

### Install

    $ bundle

### Setup database

    $ rake db:setup

### Launch

    $ rails s


Administration
--------------

Administration is handled by active_admin and accessible via `/admin/`. Default login is `email@example.org` and password `foobarspam`.

Heroku
------

### Config

    $ heroku config:set BUNDLE_WITHOUT="development:test:linux"
    $ heroku config:set GMAIL_SMTP_USER="username@gmail.com"
    $ heroku config:set GMAIL_SMTP_PASSWORD="yourpassword"

### Pulling the database

Pull in the database from heroku:

    $ heroku db:pull --confirm killbills
    $ rake db:migrate

