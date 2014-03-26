class User < ActiveRecord::Base
  MAXIMUM_HEADSHOTS = 10

  belongs_to :background_image, class_name: "Headshot"

  has_one :resume
  has_many :projects
  has_many :schools
  has_many :headshots

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :tos, acceptance: true, on: :create
  validates :name, :email, :birthday, presence: true

  def at_maximum_headshots?
    headshots.count >= MAXIMUM_HEADSHOTS
  end
end
