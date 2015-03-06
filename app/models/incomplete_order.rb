require 'mysql_connection'

IncompleteOrder = Struct.new(:order_id, :email, :code, :quantity) do
  def self.all(completed_order_ids=[])
    conn = MysqlConnection.create
    completed_order_ids.unshift(0)
    ids = completed_order_ids.map(&:to_s).join(", ")
    sql = <<-SQL
      select o.order_id, o.user_email, od.model_number, od.quantity
      from ec_orderdetail od
      join ec_order o ON o.order_id=od.order_id
      where o.order_id NOT IN (#{ids})
      order by o.order_id
    SQL
    all = conn.query sql
    if all.any?
      all.map do |r|
        new *r.values_at("order_id", "user_email", "model_number", "quantity")
      end
    end
  end
end
