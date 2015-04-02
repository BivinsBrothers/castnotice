class EventSerializer < ActiveModel::Serializer
  include SharedEventSerializerDefinitions

  attributes :id, :project_title, :project_type, :region, :storyline, :start_date,
    :how_to_audition, :audition_date, :paid, :location, :casting_director,
    :special_notes, :staff, :pay_rate, :production_location, :stipend

  has_many :unions
  has_many :roles

  def start_date
    if object.start_date.present?
      object.start_date.strftime("%a, %b %e %Y")
    else
      "N/A"
    end
  end

end
