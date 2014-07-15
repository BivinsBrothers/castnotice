source "https://rubygems.org"

ruby "2.1.2"

gem "rails", "4.1"

gem "pg"

# Assets
gem "coffee-rails", "~> 4.0.0"
gem "sass-rails", "~> 4.0.0"
gem "uglifier", ">= 1.3.0"

gem "active_model_serializers"
gem "countries"
gem "devise"
gem "elasticsearch-rails"
gem "elasticsearch-model"
gem "figaro"
gem "friendly_id"
gem "fog"
gem "jquery-rails"
gem "jquery-ui-rails"
gem "high_voltage"
gem "carrierwave"
gem "mini_magick"
gem "periscope-activerecord"
gem "pry-rails"
gem "tzinfo", platforms: [:mingw, :mswin]
gem "tzinfo-data", platforms: [:mingw, :mswin]
gem "honeybadger"
gem "stripe-rails"
gem "interactor-rails"
gem "draper"
gem "sucker_punch"

group :production, :staging do
  gem "rails_12factor"
  gem "unicorn"
end

group :development, :test do
  gem "capybara"
  gem "capybara-ui", github: "collectiveidea/capybara-ui"
  gem "capybara-email"
  gem "database_cleaner"
  gem "factory_girl_rails"
  gem "poltergeist"
  gem "rspec-rails"
  gem "launchy"
  gem "domino"
  gem "timecop"
  gem "puffing-billy"
end

group :development do
  gem "spring"
  gem "spring-commands-rspec"
end

group :test do
  gem "codeclimate-test-reporter", require: nil
  gem "webmock"
  gem "vcr"
end
