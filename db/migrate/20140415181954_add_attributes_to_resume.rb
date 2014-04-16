class AddAttributesToResume < ActiveRecord::Migration
  def change
    add_column :resumes, :gender, :string
    add_column :resumes, :hair_length, :string
    add_column :resumes, :piercing, :string
    add_column :resumes, :tattoo, :string
    add_column :resumes, :nudity, :string
    add_column :resumes, :citizen, :string
    add_column :resumes, :passport, :boolean
  end
end
