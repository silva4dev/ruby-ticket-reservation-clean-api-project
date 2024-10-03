# frozen_string_literal: true

require 'uuid'

require_relative '../value_object'
require_relative '../errors/invalid_uuid_error'

module Common
  module Domain
    module ValueObjects
      class Uuid < ValueObject
        UUID_REGEX = /\A[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}\z/i

        def initialize(value = UUID.new.generate)
          super(value)
          validate
        end

        private

        def validate
          raise Errors::InvalidUuidError, value unless valid_uuid?(value)
        end

        def valid_uuid?(uuid)
          uuid.match?(UUID_REGEX)
        end
      end
    end
  end
end
