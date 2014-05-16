class Project < ActiveRecord::Base
  belongs_to :resume
  belongs_to :project_type
end
