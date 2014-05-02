class RemoveUnionsStringFromResume < ActiveRecord::Migration
  def change
    remove_column :resumes, :unions
  end
end
