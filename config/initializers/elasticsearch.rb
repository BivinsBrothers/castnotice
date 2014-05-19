if Rails.env.staging? || Rails.env.production?
  Elasticsearch::Model.client = Elasticsearch::Client.new host: ENV['SEARCHBOX_SSL_URL']
end
