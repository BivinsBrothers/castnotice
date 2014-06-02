class Critique < ActiveRecord::Base
  belongs_to :user
  has_many :headshots, as: :imageable
  has_many :videos, as: :videoable

  has_one :response, class: CritiqueResponse

  accepts_nested_attributes_for :headshots, :videos, reject_if: :all_blank

  before_save :set_uuid

  def set_uuid
    self.uuid = SecureRandom.uuid if self.uuid.nil?
  end
end
