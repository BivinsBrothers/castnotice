class AddPaymentInfoToCritiques < ActiveRecord::Migration
  def change
    add_column :critiques, :stripe_charge_id, :string
    add_column :critiques, :payment_method, :string
  end
end
