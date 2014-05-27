class User < ActiveRecord::Base
  MAXIMUM_HEADSHOTS = 10
  MAXIMUM_VIDEOS = 10

  has_one :resume
  has_one :background_image, -> { where is_background: true }, class_name: Headshot

  has_many :projects
  has_many :schools
  has_many :headshots
  has_many :videos

  has_many :received_messages, class: Message, foreign_key: :receipient_id
  has_many :sent_messages, class: Message, foreign_key: :sender_id
  has_many :unread_messages, -> { where recipient_read_at: nil }, foreign_key: :recipient_id, class: Message
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

  def conversations
    Converation.where("sender_id = ? OR recipient_id = ?", id, id)
  end

  def talent?
    mentor == false
  end

  def mentor?
    mentor
  end
end
