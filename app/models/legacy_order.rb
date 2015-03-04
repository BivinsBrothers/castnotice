require 'mysql_connection'

class LegacyOrder
  LineItem = Struct.new(:orderdetail_id, :model_number, :quantity)

  def self.find(id)
    return unless id.present?
    all = MysqlConnection.create.query <<-SQL
      select order_id, orderdetail_id, model_number, quantity
      from ec_orderdetail
      where order_id=#{id}
    SQL
    if all.any?
      line_items = all.map do |r|
        LineItem.new *r.values_at("orderdetail_id", "model_number", "quantity")
      end
      new all.first["order_id"], line_items
    end
  end

  attr_accessor :id, :line_items
  def initialize(id, line_items)
    @id, @line_items = id, line_items
  end

  def model_numbers
    line_items.map(&:model_number).uniq
  end

  def camp
    return @camp if defined?(@camp)
    model_numbers.each do |mn|
      @camp = Camp.find_by(code: mn)
      break if @camp
    end
    @camp
  end

  def camper_count
    line_items.select {|li| li.model_number == camp.try(:code) }.map(&:quantity).sum
  end
end
