class AddReferralFieldsToCamperRegistrations < ActiveRecord::Migration
  def change
    change_table :camper_registrations do |t|
      t.string :how_heard, null: false
      t.string :referral_name, :referral_email
    end
  end
end
