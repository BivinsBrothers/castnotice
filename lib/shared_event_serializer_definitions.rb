module SharedEventSerializerDefinitions
  def audition_date
    object.audition_date.strftime("%Y-%m-%d")
  end

  def region
    object.region.name
  end

  def project_type
    object.project_type.name
  end
end
