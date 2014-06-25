class AddBiographyToMentorBios < ActiveRecord::Migration
  def change
    add_column :mentor_bios, :biography, :text
  end
end
