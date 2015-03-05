class AddAgreedToMedicalReleaseToCampers < ActiveRecord::Migration
  def change
    change_table :campers do |t|
      t.boolean :agreed_to_medical_release, null: false, default: false
    end
  end
end
