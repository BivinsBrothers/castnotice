if Rails.env.staging? || Rails.env.production?
  Elasticsearch::Model.client = Elasticsearch::Client.new(hosts: [
    { host: Figaro.env.searchbox_ssl_url,
      port: "443",
      scheme: "https"
    } ])
end
