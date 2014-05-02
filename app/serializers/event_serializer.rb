class EventSerializer < ActiveModel::Serializer
  include SharedEventSerializerDefinitions

  attributes :id, :name, :project_type, :region, :performer_type, :character, :pay, :unions,
    :director, :story, :description, :audition, :audition_date, :start_date, :end_date, :paid,
    :location, :casting_director, :writers, :producers

  def start_date
    object.start_date.strftime("%m-%d-%y")
  end

  def end_date
    object.end_date.strftime("%m-%d-%y")
  end

  def unions
    (object.unions.map &:name).to_sentence
  end
end
