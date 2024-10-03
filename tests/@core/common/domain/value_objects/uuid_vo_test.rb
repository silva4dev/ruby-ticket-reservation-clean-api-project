# frozen_string_literal: true

require_relative '../../../../test_helper'
require_relative '../../../../../src/@core/common/domain/value_objects/uuid_vo'

class UuidTest < Minitest::Test
  def setup
    @sut = Common::Domain::ValueObjects::Uuid.new('84df48d0-5c35-013d-d217-00155d5361ff')
  end

  def test_create_new_uuid_vo
    assert_equal '84df48d0-5c35-013d-d217-00155d5361ff', @sut.value
  end
end
