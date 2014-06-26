class RollSerializer < ActiveModel::Serializer
  attributes :description, :gender, :ethnicity, :age_min, :age_max
end
