require "active_support/concern"

module CategoryModelHelpers
  extend ActiveSupport::Concern

  module ClassMethods
    def names
      Hash[
        self.all.map do |object|
          [object.id, object.name]
        end
      ]
    end
  end
end
