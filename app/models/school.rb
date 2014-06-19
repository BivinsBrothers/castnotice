class School < ActiveRecord::Base
  EDUCATION_TYPES = %w( university college studio academy private_training )

  validates :education_type, inclusion: { in: EDUCATION_TYPES }

  belongs_to :resume
end
