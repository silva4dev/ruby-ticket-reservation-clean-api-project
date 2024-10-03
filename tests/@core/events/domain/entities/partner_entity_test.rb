# frozen_string_literal: true

require 'date'

require_relative '../../../../test_helper'
require_relative '../../../../../src/@core/events/domain/entities/partner_entity'
require_relative '../../../../../src/@core/events/domain/entities/event_entity'

class PartnerEntityTest < Minitest::Test
  def setup
    @sut = Events::Domain::Entities::Partner.create({
      name: 'John Doe'
    })
    @event = @sut.init_event({
      name: 'Test Event',
      description: 'A description of the test event',
      date: DateTime.now
    })
  end

  def test_create_new_partner
    assert_instance_of Events::Domain::Entities::Partner, @sut
    refute_nil @sut.id
    assert_instance_of Common::Domain::ValueObjects::Uuid, @sut.id
    assert_equal 'John Doe', @sut.name
  end

  def test_create_new_event
    assert_instance_of Events::Domain::Entities::Event, @event
    refute_nil @event.id
    assert_instance_of Common::Domain::ValueObjects::Uuid, @event.id
    assert_equal 'Test Event', @event.name
    assert_equal 'A description of the test event', @event.description
  end
end
