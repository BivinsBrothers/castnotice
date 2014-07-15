class CritiqueResponse < ActiveRecord::Base
  belongs_to :user
  belongs_to :critique

  validates_presence_of :body

  has_many :videos, as: :videoable
  accepts_nested_attributes_for :videos
end
