# frozen_string_literal: true

require_relative '../../../../test_helper'
require_relative '../../../../../src/@core/common/domain/value_objects/name_vo'

class NameVoTest < Minitest::Test
  def setup
    @sut = Common::Domain::ValueObjects::Name.new('John Doe')
  end

  def test_create_new_name_valid
    assert_equal @sut.value, 'John Doe'
  end
end
