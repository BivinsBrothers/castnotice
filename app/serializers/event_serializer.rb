class EventSerializer < ActiveModel::Serializer
  include SharedEventSerializerDefinitions

  attributes :id, :project_title, :project_type, :region, :storyline,
    :how_to_audition, :audition_date, :paid, :location, :casting_director,
    :special_notes, :staff, :pay_rate, :production_location

  has_many :unions
  has_many :roles

end
