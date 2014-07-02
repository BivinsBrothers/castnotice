class Critique < ActiveRecord::Base
  TYPES = %w( dance voice acting college_university modeling )

  belongs_to :user
  has_many :headshots, as: :imageable
  has_many :videos, as: :videoable

  has_one :response, class: CritiqueResponse

  accepts_nested_attributes_for :headshots, :videos, reject_if: :all_blank

  serialize :types

  validate :validate_types

  def types=(types)
    types &&= types.reject(&:blank?)
    super
  end

  private

  def validate_types
    self.types.each do |type|
      unless TYPES.include?(type)
        errors.add(:types, "is not a valid critique type")
      end
    end
  end

  before_save :set_uuid

  def set_uuid
    self.uuid = SecureRandom.uuid if self.uuid.nil?
  end
end
