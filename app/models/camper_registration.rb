class CamperRegistration < ActiveRecord::Base
  belongs_to :camp
  has_many :campers

  validates_presence_of :order_id, :how_heard
  validates_presence_of :referral_name, :referral_email, if: :referring?

  accepts_nested_attributes_for :campers

  def set_missing_passwords
    campers.each do |c|
      if c.user && c.user.encrypted_password.blank?
        c.user.password = SecureRandom.hex
      end
    end
  end

  def set_resumes
    campers.each do |c|
      if c.user && c.user.resume.nil?
        c.user.build_resume
      end
    end
  end

  def send_password_reset_emails!
    campers.each do |camper|
      if user = camper.user
        if user.sign_in_count.to_i == 0
          user.reset_campers_password_instructions!
        end
      end
    end
  end

  def referring?
    referral_email.present? || referral_name.present?
  end

  def camper_count
    campers.size
  end
end
