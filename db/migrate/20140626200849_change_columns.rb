class ChangeColumns < ActiveRecord::Migration
  def change
    change_column :events, :pay_rate, :text
  end
end
