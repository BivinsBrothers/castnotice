class ResumeForm
  include ActiveModel::Model

  attr_accessor :user, :name, :email, :birthday, :phone, :weight, :hair_color, :eye_color, :unions, :agent_name,
                :agent_phone, :additional_skills, :height_feet, :height_inches

  def height
    (@height_feet.to_i * 12) + @height_inches.to_i
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
      name: name,
      email: email,
      birthday: birthday
    )

    if user.resume
      user.resume.update_attributes(resume_attributes)
    else
      user.create_resume(resume_attributes)
    end
  end

  private

  def resume_attributes
    {
      phone: phone,
      weight: weight,
      hair_color: hair_color,
      eye_color: eye_color,
      unions: unions,
      agent_name: agent_name,
      agent_phone: agent_phone,
      additional_skills: additional_skills,
      height: height
    }
  end
end