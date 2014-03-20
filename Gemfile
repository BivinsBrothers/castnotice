source "https://rubygems.org"

ruby "2.1.1"

gem "rails", "4.0.2"

gem "pg"

# Assets
gem "coffee-rails", "~> 4.0.0"
gem "sass-rails", "~> 4.0.0"
gem "uglifier", ">= 1.3.0"

gem "countries"
gem "devise"
gem "figaro"
gem "jquery-rails"
gem "turbolinks"
gem "high_voltage"
gem "carrierwave"
gem "mini_magick"

group :production do
  gem "rails_12factor"
end

group :development, :test do
  gem "capybara"
  gem "capybara-ui", github: "collectiveidea/capybara-ui"
  gem "database_cleaner"
  gem "factory_girl_rails"
  gem "poltergeist"
  gem "pry"
  gem "rspec-rails"
  gem "launchy"
end

group :test do
  gem "codeclimate-test-reporter", require: nil
end
