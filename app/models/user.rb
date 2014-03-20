class User < ActiveRecord::Base
  has_one :resume
  has_many :projects
  has_many :schools

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :tos, acceptance: true, on: :create
  validates :name, :email, :birthday, presence: true

end
