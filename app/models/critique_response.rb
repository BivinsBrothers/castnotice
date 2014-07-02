class CritiqueResponse < ActiveRecord::Base
  belongs_to :user
  belongs_to :critique

  validates_presence_of :body
end
