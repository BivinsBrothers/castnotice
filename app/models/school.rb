class School < ActiveRecord::Base
  EDUCATION_TYPES = %w( university college studio academy private_training )

  belongs_to :resume
end
