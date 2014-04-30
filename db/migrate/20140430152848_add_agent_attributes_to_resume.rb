class AddAgentAttributesToResume < ActiveRecord::Migration
  def change
    add_column :resumes, :agent_email, :string
    add_column :resumes, :agent_location, :string
    add_column :resumes, :agent_location_two, :string
    add_column :resumes, :agent_city, :string
    add_column :resumes, :agent_state, :string
    add_column :resumes, :agent_zip, :string
  end
end
