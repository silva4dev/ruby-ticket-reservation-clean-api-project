# frozen_string_literal: true

require_relative '../../../../test_helper'
require_relative '../../../../../src/@core/events/domain/entities/event_spot_entity'

class EventSpotEntityTest < Minitest::Test
  def setup
    @sut = Events::Domain::Entities::EventSpot.create
  end

  def test_create_new_event_spot
    assert_instance_of Events::Domain::Entities::EventSpot, @sut
    refute_nil @sut.id
    assert_nil @sut.location
    refute @sut.is_reserved
    refute @sut.is_published
  end
end
