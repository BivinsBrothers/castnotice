# CastNotice

[![Code Climate](https://codeclimate.com/repos/52fe5b7c69568079cf00815e/badges/654c999e3c37d876d790/gpa.png)](https://codeclimate.com/repos/52fe5b7c69568079cf00815e/feed)

## Running

### Requirements

* Ruby 2.1.0
* PostgreSQL

### Setup

1. Clone the repo
2. `bundle`
3. `cp config/database.example.yml config/database.yml` and modify if needed
4. `rake db:setup`
5. `cp config/application.example.yml config/application.yml` and set the missing values
6. `rails server`

## Contributing

1. Clone repository. `git clone git@github.com:collectiveidea/castnotice.git`
2. Create a branch for your feature. `git checkout -b my-awesome-feature-name`
3. Make changes and commit.
4. Run the tests. `rake`
5. Push to remote branch. `git push origin my-awesome-feature-name`
6. Create a Pull Request. Visit `https://github.com/collectiveidea/castnotice/compare/jp-dc-awesome-feature`

## Deploying
