# frozen_string_literal: true

require 'date'

require_relative '../../../../test_helper'
require_relative '../../../../../src/@core/events/domain/entities/event_entity'
require_relative '../../../../../src/@core/events/domain/entities/event_section_entity'
require_relative '../../../../../src/@core/events/domain/entities/event_spot_entity'
require_relative '../../../../../src/@core/common/domain/value_objects/uuid_vo'

class EventTest < Minitest::Test
  def setup
    @sut = Events::Domain::Entities::Event.create(
      name: 'Test Event',
      description: 'A description of the test event',
      date: DateTime.now,
      partner_id: Common::Domain::ValueObjects::Uuid.new
    )

    @sut.add_section(
      name: 'VIP Section',
      description: 'Exclusive access to the VIP area',
      total_spots: 100,
      price: 150.50
    )
  end

  def test_create_new_event
    assert_instance_of Events::Domain::Entities::Event, @sut
    refute_nil @sut.id
    assert_equal 'Test Event', @sut.name
    assert_equal 'A description of the test event', @sut.description
    assert_instance_of DateTime, @sut.date
    assert_equal 1, @sut.sections.count
    assert_equal false, @sut.is_published
    assert_equal 100, @sut.total_spots
    assert_equal 0, @sut.total_spots_reserved
    assert_equal 100, @sut.sections.first.spots.size
  end

  def test_publish_all_event_items
    @sut.add_section(
      name: 'VIP Section 2',
      description: 'Exclusive access to the VIP area 2',
      total_spots: 25,
      price: 75.25
    )

    @sut.publish_all

    assert_equal true, @sut.is_published
    assert_equal true, @sut.sections.to_a.first.is_published
    assert_equal true, @sut.sections.to_a.last.is_published
    @sut.sections.each do |section|
      section.spots.each do |spot|
        assert_equal true, spot.is_published
      end
    end
  end
end
