class LimitedEventSerializer < ActiveModel::Serializer
  include SharedEventSerializerDefinitions

  attributes :project_title, :project_type, :region, :audition_date, :paid
end
