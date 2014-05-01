module SharedEventSerializerDefinitions
  def audition_date
    object.audition_date.strftime("%Y-%m-%d")
  end

  def region
    object.region.name
  end
end
