require "capybara/rspec"
require "capybara/poltergeist"
require "capybara/email/rspec"

Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, inspector: true, timeout: 60)
end
