class ResumeDisability < ActiveRecord::Base
  belongs_to :resume
  belongs_to :disability
end
