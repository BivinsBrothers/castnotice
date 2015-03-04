class CreateCampers < ActiveRecord::Migration
  def change
    create_table :campers do |t|
      t.references :camper_registration, null: false
      t.references :user, null: false
      # on user table: email, name, birthday, address, city, state, zip
      # all parent fields
      t.string :grade, :gender, null: false
      t.string :home_phone, null: false, default: "N/A"
      t.string :cell_phone, null: false
      t.string :emergency_contact_name, :emergency_contact_phone, :emergency_contact_relationship
      t.text :medical_history, null: false, default: "N/A"
      t.text :medical_current_medication, null: false, default: "N/A"
      t.text :medical_allergies, null: false, default: "N/A"
      t.string :shirt_size, :school, null: false
      t.string :referred_by
      t.boolean :agreed_to_refund_policy, :photo_release, null: false, default: false
    end
  end
end
