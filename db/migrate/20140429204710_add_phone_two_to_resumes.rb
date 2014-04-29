class AddPhoneTwoToResumes < ActiveRecord::Migration
  def change
    add_column :resumes, :phone_two, :string
  end
end
