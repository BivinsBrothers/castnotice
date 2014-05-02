class Event < ActiveRecord::Base
  validates :name, presence: true

  belongs_to :region
  belongs_to :project_type

  has_and_belongs_to_many :unions

  def unions_sentence
    (unions.map &:name).to_sentence
  end
end
