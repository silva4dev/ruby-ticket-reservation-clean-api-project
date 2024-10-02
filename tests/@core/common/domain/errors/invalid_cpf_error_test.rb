# frozen_string_literal: true

require_relative '../../../../test_helper'
require_relative '../../../../../src/@core/common/domain/errors/invalid_cpf_error'

class InvalidCpfErrorTest < Minitest::Test
  def test_error_message
    error_message = 'Invalid CPF provided'
    error = Common::Domain::Errors::InvalidCpfError.new(error_message)

    assert_equal error_message, error.message
  end

  def test_error_is_a_standard_error
    error = Common::Domain::Errors::InvalidCpfError.new('Invalid CPF')

    assert_kind_of StandardError, error
  end
end
