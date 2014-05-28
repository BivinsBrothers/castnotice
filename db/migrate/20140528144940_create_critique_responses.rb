class CreateCritiqueResponses < ActiveRecord::Migration
  def change
    create_table :critique_responses do |t|
      t.text     "response"
      t.integer  "critique_id"
      t.integer  "user_id"
      t.datetime "created_at"
      t.datetime "updated_at"

    end
  end
end
