class ResumeForm
  include ActiveModel::Model
  include ActiveModel::Validations
  include ::ResumeFormHelpers

  attr_accessor :user, :resume, :name, :email, :birthday, :phone, :weight,
                :hair_color, :eye_color, :unions, :agent_name, :agent_phone,
                :additional_skills, :height_feet, :height_inches, :attributes

  validates :name, :email, :phone, :birthday, presence: true

  def initialize(user, attributes={})
    @attributes = attributes
    @user = user
    @resume = @user.resume

    consolidate_birthday

    if user.resume.present?
      @attributes = resume.resume_form_attributes.merge!(@attributes)
    end

    super(@attributes)
  end

  def height
    (@height_feet.to_i * 12) + @height_inches.to_i
  end

  def height=(inches)
    inches = 0 if inches.nil?

    @height_feet = inches / 12
    @height_inches = inches % 12
  end

  def name
    user.name
  end

  def email
    user.email
  end

  def birthday
    user.birthday
  end

  def save
    user.attributes = { name: @name, email: @email, birthday: @birthday }
    resume.attributes = resume_form_attributes

    if valid? && user.valid? && resume.valid?
      user.save!
      resume.save!
    end
  end

  private

  def consolidate_birthday
    @attributes["birthday"] = Date.civil(
      @attributes.delete("birthday(1i)").to_i,
      @attributes.delete("birthday(2i)").to_i,
      @attributes.delete("birthday(3i)").to_i
    ) if @attributes["birthday(1i)"].present?
  end

end
