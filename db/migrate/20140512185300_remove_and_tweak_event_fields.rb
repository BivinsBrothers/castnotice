class RemoveAndTweakEventFields < ActiveRecord::Migration
  def change
    remove_column :events, :pay, :string
    remove_column :events, :end_date, :datetime
    remove_column :events, :performer_type, :string
    remove_column :events, :character, :string
    remove_column :events, :producers, :string
    remove_column :events, :writers, :string
    remove_column :events, :director, :string

    add_column :events, :gender, :string
    add_column :events, :project_type_details, :text
    add_column :events, :special_notes, :text
    add_column :events, :additional_project_info, :text

    rename_column :events, :audition, :how_to_audition
    rename_column :events, :description, :character_description
    rename_column :events, :story, :storyline
    rename_column :events, :name, :project_title
  end
end
