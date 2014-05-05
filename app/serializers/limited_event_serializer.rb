class LimitedEventSerializer < ActiveModel::Serializer
  include SharedEventSerializerDefinitions

  attributes :name, :project_type, :region, :performer_type, :audition_date, :paid
end
