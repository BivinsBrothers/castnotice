# CastNotice

[![Code Climate](https://codeclimate.com/repos/52fe5b7c69568079cf00815e/badges/654c999e3c37d876d790/gpa.png)](https://codeclimate.com/repos/52fe5b7c69568079cf00815e/feed)
[![Build Status](https://magnum.travis-ci.com/collectiveidea/castnotice.png?token=f5vwtAyNvXmqqy3GsP2X&branch=master)](https://magnum.travis-ci.com/collectiveidea/castnotice)

## Running

### Requirements

* Ruby 2.1.0
* PostgreSQL
* Elasticsearch
* PhantomJS (for running tests)

### Setup

1. Clone the repo
2. `brew bundle` (on OS X. Install Requirements above for other platforms)
3. `bundle`
4. `cp config/database.example.yml config/database.yml` and modify if needed
5. `cp config/application.example.yml config/application.yml` and set the missing values
6. `rake db:setup`
7. `rake db:seed`
8. `rails server`

## Contributing

1. Clone repository. `git clone git@github.com:collectiveidea/castnotice.git`
2. Create a branch for your feature. `git checkout -b my-awesome-feature-name`
3. Make changes and commit.
4. Run the tests. `rake`
5. Push to remote branch. `git push origin my-awesome-feature-name`
6. Create a Pull Request. Visit `https://github.com/collectiveidea/castnotice/compare/jp-dc-awesome-feature`

## Payment integration

We are using Stripe to handle payments via their plan system. The `stripe-rails` gem allows us to define
our plans in `config/stripe/plans.rb`. To build these plans on the currently configured Stripe account
run `rake stripe:prepare`. This command is idempotent so can be run any number of times as part of the
build process if we want.

## Deploying

### Staging
Travis CI is configured to push changes to staging whenever the master branch passes all tests.

Environment name:
heroku: castnotice-stage
