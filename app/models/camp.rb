class Camp < ActiveRecord::Base
  validates_presence_of :name, :code
  validates_uniqueness_of :code

  has_many :camper_registrations

  def camper_count
    camper_registrations.map(&:camper_count).sum
  end
end
