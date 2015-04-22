class CampersList < ActiveRecord::Base

  scope :by_code, proc { |code| where(code: code) }

  def self.send_invitation(code)
    campers = CampersList.by_code(code)
    campers.each do |camper|
      email = camper.user_email
      link = "http://www.castnotice.com/camper_registration/new?order_id=#{camper.order_id}"

      Notifier.invite_campers(email, link).deliver
    end
  end
end
