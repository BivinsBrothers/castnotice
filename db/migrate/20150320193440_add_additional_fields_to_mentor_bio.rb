class AddAdditionalFieldsToMentorBio < ActiveRecord::Migration
  def change
    add_column :mentor_bios, :hometown, :string
    add_column :mentor_bios, :associated_to_college, :boolean, default: false
    add_column :mentor_bios, :college, :string
    add_column :mentor_bios, :current_city, :string
    add_column :mentor_bios, :region_id, :integer
  end
end
