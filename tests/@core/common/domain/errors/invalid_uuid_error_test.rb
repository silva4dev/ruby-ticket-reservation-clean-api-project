# frozen_string_literal: true

require_relative '../../../../test_helper'
require_relative '../../../../../src/@core/common/domain/errors/invalid_uuid_error'

class InvalidUuidErrorTest < Minitest::Test
  def test_error_message_contains_invalid_uuid
    invalid_value = "123-invalid-uuid"
    error = Common::Domain::Errors::InvalidUuidError.new(invalid_value)

    expected_message = "Value #{invalid_value} must be a valid UUID"
    assert_equal expected_message, error.message
  end

  def test_error_is_a_standard_error
    error = Common::Domain::Errors::InvalidUuidError.new("invalid_uuid")

    assert_kind_of StandardError, error
  end
end
