source "https://rubygems.org"

ruby "2.1.1"

gem "rails", "4.1"

gem "pg"

# Assets
gem "coffee-rails", "~> 4.0.0"
gem "sass-rails", "~> 4.0.0"
gem "uglifier", ">= 1.3.0"

gem "active_model_serializers"
gem "countries"
gem "devise"
gem "figaro"
gem "fog"
gem "jquery-rails"
gem "jquery-ui-rails"
gem "high_voltage"
gem "carrierwave"
gem "mini_magick"
gem "pry-rails"

group :production do
  gem "rails_12factor"
end

group :development, :test do
  gem "capybara"
  gem "capybara-ui", github: "collectiveidea/capybara-ui"
  gem "database_cleaner"
  gem "factory_girl_rails"
  gem "poltergeist"
  gem "rspec-rails"
  gem "launchy"
  gem "domino"
end

group :development do
  gem "spring"
  gem "spring-commands-rspec"
end

group :test do
  gem "codeclimate-test-reporter", require: nil
end
