# frozen_string_literal: true

module Common
  module Domain
    module Errors
      class InvalidUuidError < StandardError
        def initialize(invalid_value)
          super("Value #{invalid_value} must be a valid UUID")
        end
      end
    end
  end
end
