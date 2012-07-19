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

Install rvm with rubygems, then :

    $ rvm install 1.9.2
    $ rvm gemset create killbills

### Download

    $ git clone https://github.com/sunny/killbills.git
    $ cd killbills

### Install

    $ gem install bundler
    $ bundle

### Setup database

    $ rake db:setup

### Launch

    $ rails server


Administration
--------------

Administration is handled by active_admin and accessible via /admin/.

To create an administrator open a rails console:

    $ rails console
    AdminUser.create! email: "email@example.org", password: "foobarspam"

Heroku
------

### Config

    $ heroku config:add BUNDLE_WITHOUT="development:test:linux"
    $ heroku config:add GMAIL_SMTP_USER="username@gmail.com"
    $ heroku config:add GMAIL_SMTP_PASSWORD="yourpassword"

### Pulling the database

Pull in the database from heroku:

    $ heroku db:pull --confirm killbills
    $ rake db:migrate

