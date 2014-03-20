class Resume < ActiveRecord::Base
  mount_uploader :avatar, AvatarUploader

  serialize :unions

  belongs_to :user

  validates :phone, presence: true

end
