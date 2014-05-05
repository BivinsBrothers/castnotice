class Resume < ActiveRecord::Base
  serialize :unions

  belongs_to :user
  has_many :resume_unions
  has_many :unions, through: :resume_unions
end
