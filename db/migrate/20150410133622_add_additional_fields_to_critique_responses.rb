class AddAdditionalFieldsToCritiqueResponses < ActiveRecord::Migration
  def change
    add_column :critique_responses, :headshot_comment, :text
    add_column :critique_responses, :resume_comment, :text
    add_column :critique_responses, :improvement_comment, :text
    add_column :critique_responses, :overall_comment, :text
  end
end
