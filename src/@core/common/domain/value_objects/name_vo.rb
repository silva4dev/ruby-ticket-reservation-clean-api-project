# frozen_string_literal: true

require_relative '../value_object'

module Common
  module Domain
    module ValueObjects
      class Name < ValueObject
        def initialize(value)
          super(value)
        end

        def is_valid
          value.length >= 3
        end
      end
    end
  end
end

