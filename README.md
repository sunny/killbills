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

Memcached
---------

To test the production cache with Dalli, start by installing memcached. On OSX with brew:

    $ brew install memcached

Follow instructions to launch it. You can then enable caching in `development.rb`.

I18n
----

To refresh locale files in JavaScript :

    $ rake i18n:js:export


Heroku
------

### Config

    $ heroku config:set BUNDLE_WITHOUT="development:test:linux"
    $ heroku config:set GMAIL_SMTP_USER="username@gmail.com"
    $ heroku config:set GMAIL_SMTP_PASSWORD="yourpassword"


### Pulling the database

Pull in the database from heroku:

    $ bundle exec heroku db:pull
    $ rake db:migrate

TODO
----

* Bills with more than two people
* Mozilla's Persona sign-in
* Participations with a ratio (I only owe 42% of the amount)
* Recurrent bills
* Support for other means of payments than money
* Landing page that explains it all

Issues
------

https://github.com/sunny/killbills/issues
