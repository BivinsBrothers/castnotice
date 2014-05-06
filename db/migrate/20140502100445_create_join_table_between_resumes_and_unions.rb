class CreateJoinTableBetweenResumesAndUnions < ActiveRecord::Migration
  def change
    create_join_table :resumes, :unions do |t|
      t.index :resume_id
      t.index :union_id
    end
  end
end
