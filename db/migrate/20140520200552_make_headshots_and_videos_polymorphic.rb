class MakeHeadshotsAndVideosPolymorphic < ActiveRecord::Migration
  def change
    rename_column :headshots, :resume_id, :imageable_id
    add_column :headshots, :imageable_type, :string
    add_index :headshots, [:imageable_id, :imageable_type]

    rename_column :videos, :resume_id, :videoable_id
    add_column :videos, :videoable_type, :string
    add_index :videos, [:videoable_id, :videoable_type]
  end
end
