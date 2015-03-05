class Camper < ActiveRecord::Base
  belongs_to :user, inverse_of: :camper, autosave: true
  belongs_to :camper_registration

  accepts_nested_attributes_for :user

  validates_presence_of :grade, :gender, :cell_phone, :medical_history,
    :medical_allergies, :medical_current_medication, :shirt_size, :school


  validates_confirmation_of :agreed_to_refund_policy, :photo_release, :agreed_to_medical_release

  delegate :name, :email, :birthday, :address, :parent_address, :parent_name, :parent_email, :parent_phone, to: :user

  def user_attributes=(attrs)
    self.user = User.find_by(email: attrs[:email]) || build_user
    user.attributes = attrs
  end

  def emergency_contact
    if emergency_contact_name.present?
      "#{emergency_contact_name} (#{emergency_contact_relationship}), #{emergency_contact_phone}"
    end
  end

end
