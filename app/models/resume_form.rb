class ResumeForm
  include ActiveModel::Model
  include ::ResumeFormHelpers

  attr_accessor :user, :name, :email, :birthday, :phone, :weight, :hair_color, :eye_color, :unions, :agent_name,
                :agent_phone, :additional_skills, :height_feet, :height_inches, :attributes

  def initialize(user, attributes={})
    @attributes = attributes
    @user = user

    consolidate_birthday

    if user.resume.present?
      @attributes = user.resume.form_attributes_hash.merge!(@attributes)
    end

    super(@attributes)
  end

  def height
    (@height_feet.to_i * 12) + @height_inches.to_i
  end

  def height=(inches)
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
    user.update_attributes(
      name: @name,
      email: @email,
      birthday: @birthday
    )

    if user.resume
      user.resume.update_attributes(form_attributes_hash)
    else
      user.create_resume(form_attributes_hash)
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