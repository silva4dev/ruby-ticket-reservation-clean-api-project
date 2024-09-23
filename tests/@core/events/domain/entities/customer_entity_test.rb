# frozen_string_literal: true

require_relative '../../../../test_helper'
require_relative '../../../../../src/@core/events/domain/entities/customer_entity'

class CustomerEntityTest < Minitest::Test
  def setup
    @sut = Events::Domain::Entities::Customer.create({
      name: 'John Doe',
      cpf: '690.754.930-10'
    })
  end

  def test_create_new_customer
    assert_equal @sut.cpf.value, '69075493010'
    assert_equal @sut.name, 'John Doe'
  end
end
