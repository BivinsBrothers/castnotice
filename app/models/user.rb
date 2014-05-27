class User < ActiveRecord::Base
  has_one :resume
  has_many :critiques

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :tos, acceptance: true, on: :create
  validates :name, :email, :birthday, presence: true
  validates :parent_name, :parent_email, :parent_location, :parent_city, :parent_state,
    :parent_zip, :parent_phone, presence: true, on: :create, if: :under_18?

  def happy_birthday?
    birthday.day == Date.current.day && birthday.month == Date.current.month
  end

  def under_18?
    birthday > 18.years.ago
  end
end
