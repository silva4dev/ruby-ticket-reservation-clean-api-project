# frozen_string_literal: true

require 'date'

require_relative '../../../../test_helper'
require_relative '../../../../../src/@core/events/domain/entities/event_entity'
require_relative '../../../../../src/@core/events/domain/entities/event_section_entity'
require_relative '../../../../../src/@core/events/domain/entities/event_spot_entity'

class EventTest < Minitest::Test
  def setup
    @sut = Events::Domain::Entities::Event.create({
      name: 'Test Event',
      description: 'A description of the test event',
      date: DateTime.now,
      partner_id: '123e4567-e89b-12d3-a456-426614174000'
    })

    @section = Events::Domain::Entities::EventSection.create({
      name: 'VIP Section',
      description: 'Exclusive access to the VIP area',
      total_spots: 100,
      price: 150.50
    })

    @spot = Events::Domain::Entities::EventSpot.create()

    @sut.add_section(@section)
  end

  def test_create_new_event
    assert_instance_of Events::Domain::Entities::Event, @sut
    refute_nil @sut.id
    assert_equal 'Test Event', @sut.name
    assert_equal 'A description of the test event', @sut.description
    assert_instance_of DateTime, @sut.date
    assert_equal @sut.sections.count, 1
    assert_equal false, @sut.is_published
    assert_equal 100, @sut.total_spots
    assert_equal 0, @sut.total_spots_reserved
    assert_equal '123e4567-e89b-12d3-a456-426614174000', @sut.partner_id.value
  end
end
