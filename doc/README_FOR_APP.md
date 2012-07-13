Installing
==========

Setup
-----

# Postgresql

Install postgres package, then with a user allowed to administrate psql :

    $ createuser killbills
    $ createdb -Okillbills -Eutf8 killbills_development
    $ createdb -Okillbills -Eutf8 killbills_test

# Ruby 1.9.2

Install rvm, then :

    $ rvm install 1.9.2
    $ rvm gemset create killbills

# Download

    $ git clone https://github.com/sunny/killbills.git
    $ cd killbills

# Install

    $ bundle

# Create an admin user

In a rails console, type :

    $ rails console
    AdminUser.create! email: "email@example.org", password: "foobarspam"

# Launch it

    $ rails server


Heroku
------

### Config

    $ heroku config:add BUNDLE_WITHOUT="development:test:linux"


### Pulling the database

Pull in the database from heroku:

    $ heroku db:pull --confirm killbills
    $ rake db:migrate

