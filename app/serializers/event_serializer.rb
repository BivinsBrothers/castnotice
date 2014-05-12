class EventSerializer < ActiveModel::Serializer
  include SharedEventSerializerDefinitions

  attributes :id, :project_title, :project_type, :region, :storyline, :character_description,
    :how_to_audition, :audition_date, :start_date, :paid, :location, :casting_director,
    :gender, :project_type_details, :special_notes, :additional_project_info

  has_many :unions

  def start_date
    object.start_date.try(:strftime, "%m-%d-%y")
  end
end
