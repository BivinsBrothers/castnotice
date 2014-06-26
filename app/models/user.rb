class User < ActiveRecord::Base
  MAXIMUM_HEADSHOTS = 10
  MAXIMUM_VIDEOS = 10

  has_one :resume
  has_one :background_image, -> { where is_background: true }, class: Headshot
  has_one :mentor_bio
  has_many :received_messages, class: Message, foreign_key: :recipient_id
  has_many :sent_messages, class: Message, foreign_key: :sender_id
  has_many :unread_messages, -> { where recipient_read_at: nil }, foreign_key: :recipient_id, class: Message
  has_many :critiques

  has_many :critique_responses_given, class: CritiqueResponse
  has_many :critique_responses_received, class: CritiqueResponse, through: :critiques, source: :response

  accepts_nested_attributes_for :mentor_bio

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
    return false unless birthday.present?
    birthday > 18.years.ago
  end

  def conversations
    Conversation.where("sender_id = ? OR recipient_id = ?", id, id)
  end

  def correspondent_in?(conversation)
    id == conversation.recipient_id || id == conversation.sender_id
  end

  def talent?
    !mentor && !admin
  end

  def can_send_messages?
    talent?
  end

  def can_send_messages_to?(recipient)
    can_send_messages? && id != recipient.id
  end
end
