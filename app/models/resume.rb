class Resume < ActiveRecord::Base
  serialize :unions

  belongs_to :user

  validates :phone, presence: true
end
