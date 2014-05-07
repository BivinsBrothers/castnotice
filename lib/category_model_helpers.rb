require "active_support/concern"

module CategoryModelHelpers
  extend ActiveSupport::Concern

  included do
    def self.names
      self.all.map &:name
    end
  end
end
