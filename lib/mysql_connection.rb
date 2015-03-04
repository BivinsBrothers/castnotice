require 'mysql2'
require 'uri'
require 'cgi'

module MysqlConnection
  def self.create(url=ENV["MYSQL_URL"])
    url = URI(url)
    host = url.host
    user = CGI.unescape(url.user) if url.user
    password = CGI.unescape(url.password) if url.password
    db = url.path.gsub(/^\//,'')
    Mysql2::Client.new(host: host, username: user, password: password, database: db)
  end
end
