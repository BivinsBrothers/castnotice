class RemoveGenderAndCharacterDescriptionFromEvents < ActiveRecord::Migration
  def up
    remove_column :events, :gender
    remove_column :events, :character_description
  end

  def down
    add_column :events, :gender, :string
    add_column :events, :character_description, :text
  end
end
