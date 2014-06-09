class ResumeDisabilityAssistiveDevice < ActiveRecord::Base
  belongs_to :resume
  belongs_to :disability_assistive_device
end
