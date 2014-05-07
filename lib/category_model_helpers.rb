require "active_support/concern"

module CategoryModelHelpers
  extend ActiveSupport::Concern

  module ClassMethods
    def names
      self.all.map &:name
    end
  end
end
