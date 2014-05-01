class AddAgentTypeToResume < ActiveRecord::Migration
  def change
    add_column :resumes, :agent_type, :string
  end
end
