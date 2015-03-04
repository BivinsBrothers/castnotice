class CamperRegistration < ActiveRecord::Base
  belongs_to :camp
  has_many :campers

  validates_presence_of :order_id

  accepts_nested_attributes_for :campers

  def send_password_reset_emails!
    campers.each do |camper|
      if email = camper.user.try(:email)
        User.send_reset_password_instructions(email: camper.user.email)
      end
    end
  end
end
