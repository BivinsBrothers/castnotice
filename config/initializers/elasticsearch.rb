if Rails.env.staging? || Rails.env.production? || Rails.env.stage?
  Elasticsearch::Model.client = Elasticsearch::Client.new host: ENV['SEARCHBOX_SSL_URL']
end
