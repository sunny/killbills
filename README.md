Kill Bills
==========

See it running on http://killbills.me/

A Rails web app to remember the debts you have between friends.

Enter who payed for what, forget about it, and later on know for each of your friends what your current debt is.

A bit like billmonk.com, only with more ninja swords.

![Travis-CI Status](https://api.travis-ci.org/sunny/killbills.png)

Development Setup
-----------------

### PostgreSQL

Install the postgres package for your system. For example on OSX with the brew package manager:

    $ brew install postgres

Follow install instructions. Then, create a postgres user:

    $ createuser --createdb postgres

### Ruby 1.9.3

Install and use ruby 1.9.3. Have a look at rbenv or rvm to help you with that.

Also, install the bundler gem on that version of ruby.

    $ gem install bundler

### Install, setup database and launch

    $ bundle
    $ rake db:setup
    $ rails s


Heroku
------

### Config

    $ heroku config:set BUNDLE_WITHOUT="development:test:linux"
    $ heroku config:set GMAIL_SMTP_USER="username@gmail.com"
    $ heroku config:set GMAIL_SMTP_PASSWORD="yourpassword"

### Pulling the database

Pull in the database from heroku:

    $ heroku db:pull
    $ rake db:migrate

