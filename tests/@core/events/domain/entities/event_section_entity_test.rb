# frozen_string_literal: true

require_relative '../../../../test_helper'
require_relative '../../../../../src/@core/events/domain/entities/event_section_entity'

class EventSectionTest < Minitest::Test
  def setup
    @sut = Events::Domain::Entities::EventSection.create({
      name: 'VIP Section',
      description: 'Exclusive access to the VIP area',
      total_spots: 100,
      price: 150.50
    })
  end

  def test_create_new_event_section
    assert_instance_of Events::Domain::Entities::EventSection, @sut
    assert_equal 'VIP Section', @sut.name
    refute_nil @sut.id
    assert_equal 'Exclusive access to the VIP area', @sut.description
    assert_equal false, @sut.is_published
    assert_equal 100, @sut.total_spots
    assert_equal 0, @sut.total_spots_reserved
    assert_equal 150.50, @sut.price
    assert_instance_of Common::Domain::ValueObjects::Uuid, @sut.instance_variable_get(:@id)
  end
end
