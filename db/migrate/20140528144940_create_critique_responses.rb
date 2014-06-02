class CreateCritiqueResponses < ActiveRecord::Migration
  def change
    create_table :critique_responses do |t|
      t.text    :body
      t.integer :critique_id
      t.integer :user_id

      t.index   :critique_id
      t.index   :user_id

      t.timestamps
    end
  end
end
