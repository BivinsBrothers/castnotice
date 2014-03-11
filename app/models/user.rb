class User < ActiveRecord::Base
  has_one :resume
  has_many :projects
  accepts_nested_attributes_for :projects

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :tos, acceptance: true, on: :create
  validates :name, presence: true
end
