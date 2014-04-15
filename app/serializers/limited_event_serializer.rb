class LimitedEventSerializer < ActiveModel::Serializer
  attributes :name, :project_type, :region, :performer_type, :audition_date, :paid

  def audition_date
    object.audition_date.strftime("%Y-%m-%d")
  end
end