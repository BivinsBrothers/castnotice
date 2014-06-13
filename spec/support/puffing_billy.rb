require "billy/rspec"

Billy.configure do |c|
  c.cache = true
  c.persist_cache = true
  c.ignore_cache_port = true
  c.whitelist = [ '127.0.0.1', 'localhost', 'netdna.bootstrapcdn.com', 'js.stripe.com', 'fonts.googleapis.com', 'bucket.s3.amazonaws.com', 'placekitten.com', 's.ytimg.com', 'www.google.com', 'www.youtube.com' ]
  c.ignore_params = [ "https://js.stripe.com/v2", "https://api.stripe.com/v1/tokens" ]
  c.non_whitelisted_requests_disabled = false # disable new HTTP connections when true
  c.cache_path = "spec/billy_cache"
end
Capybara.javascript_driver = :poltergeist_billy
