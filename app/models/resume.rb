class Resume < ActiveRecord::Base
  serialize :unions

  belongs_to :user
  has_and_belongs_to_many :unions
end
