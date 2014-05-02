class EventSerializer < ActiveModel::Serializer
  include SharedEventSerializerDefinitions

  attributes :id, :name, :project_type, :region, :performer_type, :character, :pay,
    :director, :story, :description, :audition, :audition_date, :start_date, :end_date, :paid,
    :location, :casting_director, :writers, :producers

  has_many :unions

  def start_date
    object.start_date.strftime("%m-%d-%y")
  end

  def end_date
    object.end_date.strftime("%m-%d-%y")
  end
end
