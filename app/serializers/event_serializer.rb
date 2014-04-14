class EventSerializer < ActiveModel::Serializer
  attributes :name, :project_type, :region, :performer_type, :character, :pay, :union,
    :director, :story, :description, :audition, :audition_date, :start_date, :end_date, :paid

  def audition_date
    object.audition_date.strftime("%Y-%m-%d")
  end

  def start_date
    object.start_date.strftime("%m-%d-%y")
  end

  def end_date
    object.end_date.strftime("%m-%d-%y")
  end
end