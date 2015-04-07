class User < ActiveRecord::Base
  MAXIMUM_HEADSHOTS = 10
  MAXIMUM_VIDEOS = 10

  has_one :resume
  has_one :background_image, -> { where is_background: true }, class: Headshot
  has_one :mentor_bio
  has_one :camper
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

  validates_presence_of :location_address, :location_city, :location_state,
    :location_zip, on: :create, if: :camper

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
    talent? || admin?
  end

  def can_send_messages_to?(recipient)
    can_send_messages? && id != recipient.id && !recipient.mentor?
  end

  def eligible_for_free_critique?
    stripe_customer.subscriptions.retrieve(stripe_plan_id).plan.id.to_sym == Stripe::Plans::BROADWAY.id &&
    critiques.where(payment_method: "breakthru_free").count == 0
  end

  def address
    [location_address, location_address_two, location_city, location_state, location_zip].select(&:present?).join(", ")
  end

  def has_membership?
    stripe_customer_id.present?
  end

  def parent_address
    [parent_location, parent_location_two, parent_city, parent_state, parent_zip].select(&:present?).join(", ")
  end

  def reset_campers_password_instructions!
    token = set_reset_password_token
    Notifier.reset_campers_password_instructions(self, token).deliver
  end

  def stripe_customer
    @stripe_customer ||= begin
      Stripe::Customer.retrieve(stripe_customer_id)
    rescue Exception => e
      raise "Unable to load stripe customer: #{e.message}"
    end
  end
end
