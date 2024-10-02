# frozen_string_literal: true

require_relative '../../../../test_helper'
require_relative '../../../../../src/@core/events/domain/entities/customer_entity'
require_relative '../../../../../src/@core/common/domain/value_objects/uuid_vo'

class CustomerEntityTest < Minitest::Test
  def setup
    @sut = Events::Domain::Entities::Customer.create({
      name: 'John Doe',
      cpf: '690.754.930-10'
    })
  end

  def test_create_new_customer
    assert_instance_of Events::Domain::Entities::Customer, @sut
    refute_nil @sut.id
    assert_instance_of Common::Domain::ValueObjects::Uuid, @sut.id
    assert_equal @sut.cpf.value, '69075493010'
    assert_equal @sut.name, 'John Doe'
  end
end
