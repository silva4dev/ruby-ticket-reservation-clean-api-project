# frozen_string_literal: true

require_relative '../../../../test_helper'
require_relative '../../../../../src/@core/events/domain/entities/partner_entity'

class PartnerTest < Minitest::Test
  def setup
    @sut = Events::Domain::Entities::Partner.create({
      name: 'John Doe'
    })
  end

  def test_create_new_partner
    assert_instance_of Events::Domain::Entities::Partner, @sut
    refute_nil @sut.id
    assert_instance_of Common::Domain::ValueObjects::Uuid, @sut.id
    assert_equal @sut.name, 'John Doe'
    @sut = Events::Domain::Entities::Partner.new(
      id: '84df48d0-5c35-013d-d217-00155d5361ff',
      name: 'Mary Doe'
    )
    assert_equal @sut.id.value, '84df48d0-5c35-013d-d217-00155d5361ff'
    assert_equal @sut.name, 'Mary Doe'
    @other = Events::Domain::Entities::Partner.new(
      id: @sut.id.value,
      name: 'John Doe'
    )
    assert_equal @sut.equals(@other), true
  end
end
