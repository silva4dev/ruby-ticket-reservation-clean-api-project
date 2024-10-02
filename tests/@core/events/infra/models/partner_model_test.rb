# frozen_string_literal: true

require_relative '../../../../test_helper'
require_relative '../../../../../src/@core/events/infra/models/partner_model'
require_relative '../../../../../src/@core/events/domain/entities/partner_entity'

class PartnerModelTest < Minitest::Test
  def setup
    DatabaseCleaner.start
  end

  def teardown
    DatabaseCleaner.clean
  end

  def test_create_new_partner
    @partner = Events::Domain::Entities::Partner.create({
      name: 'John Doe'
    })

    @sut = Events::Infra::Models::Partner.create(
      id: @partner.id.value,
      name: @partner.name
    )

    assert_equal @sut.id, @partner.id.value
    assert_equal @sut.name, @partner.name
  end
end
