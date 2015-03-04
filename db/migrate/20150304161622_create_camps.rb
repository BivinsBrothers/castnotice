class CreateCamps < ActiveRecord::Migration
  def change
    create_table :camps do |t|
      t.string :name, :code, null: false
    end
  end
end
