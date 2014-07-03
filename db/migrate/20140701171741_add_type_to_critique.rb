class AddTypeToCritique < ActiveRecord::Migration
  def change
    add_column :critiques, :types, :string
  end
end
