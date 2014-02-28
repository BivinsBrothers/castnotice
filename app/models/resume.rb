class Resume < ActiveRecord::Base
  include ResumeFormHelpers

  serialize :unions

  belongs_to :user
end
