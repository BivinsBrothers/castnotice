class Camper < ActiveRecord::Base
  belongs_to :user
  belongs_to :camper_registration

  accepts_nested_attributes_for :user

  validates_presence_of :grade, :gender, :cell_phone, :medical_history, :medical_allergies, :medical_current_medication,
    :shirt_size, :school

  validates_confirmation_of :agreed_to_refund_policy, :photo_release
end