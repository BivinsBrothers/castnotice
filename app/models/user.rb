class User < ActiveRecord::Base
  has_one :resume
  has_many :projects
  has_many :schools

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :tos, acceptance: true, on: :create
  validates :name, :email, :birthday, presence: true

  private

  def consolidate_birthday
    @attributes["birthday"] = Date.civil(
        @attributes.delete("birthday(1i)").to_i,
        @attributes.delete("birthday(2i)").to_i,
        @attributes.delete("birthday(3i)").to_i
    ) if @attributes["birthday(1i)"].present?
  end
end
