class FluentLanguage < ActiveRecord::Base
  include CategoryModelHelpers

  validates :name, presence: true
end
