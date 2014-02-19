class User < ActiveRecord::Base
  has_one :resume

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :tos, acceptance: true, on: :create
  validates :name, presence: true
end
