# frozen_string_literal: true

require_relative '../../../../test_helper'
require_relative '../../../../../src/@core/common/domain/value_objects/cpf_vo'

class CpfTest < Minitest::Test
  def setup
    @sut = Common::Domain::ValueObjects::Cpf.new('491.903.160-29')
  end

  def test_create_new_cpf_vo
    assert_equal @sut.value, '49190316029'
  end
end
