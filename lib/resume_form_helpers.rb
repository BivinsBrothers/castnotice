module ResumeFormHelpers
  def form_attributes_hash
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
