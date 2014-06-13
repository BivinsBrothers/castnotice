VCR.configure do |c|
  c.ignore_localhost = true
  c.allow_http_connections_when_no_cassette = true
  c.cassette_library_dir = "spec/cassettes"
  c.default_cassette_options = { record: :new_episodes }
  c.hook_into :webmock
  c.configure_rspec_metadata!
end
WebMock.allow_net_connect!
