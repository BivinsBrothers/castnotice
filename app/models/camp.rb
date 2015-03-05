require 'csv'

class Camp < ActiveRecord::Base
  validates_presence_of :name, :code
  validates_uniqueness_of :code

  has_many :camper_registrations

  def camper_count
    camper_registrations.map(&:camper_count).sum
  end

  def campers
    camper_registrations.includes(campers: :user).flat_map(&:campers)
  end

  def to_csv
    cs = campers
    CSV.generate do |csv|
      csv << %w[Order Name Email Birthday Address School Grade Gender Cell Home
                Shirt Parent ParentEmail ParentAddress ParentPhone
                Emergency MedicalHistory Medication Allergies
                ReferredBy ReferralName ReferralEmail HowHeard]
      cs.each do |camper|
        csv << [
          camper.camper_registration.order_id,
          camper.name,
          camper.email,
          camper.birthday,
          camper.address,
          camper.school,
          camper.grade,
          camper.gender,
          camper.cell_phone,
          camper.home_phone,

          camper.shirt_size,
          camper.parent_name,
          camper.parent_email,
          camper.parent_address,
          camper.parent_phone,
          camper.emergency_contact,
          camper.medical_history,
          camper.medical_current_medication,
          camper.medical_allergies,

          camper.referred_by,
          camper.camper_registration.referral_name,
          camper.camper_registration.referral_email,
          camper.camper_registration.how_heard
        ]
      end
    end
  end
end
