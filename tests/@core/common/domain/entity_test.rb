# frozen_string_literal: true

require_relative '../../../test_helper'
require_relative '../../../../src/@core/common/domain/entity'

class EntityTest < Minitest::Test
  class TestEntity < Common::Domain::Entity
    attr_reader :id

    def initialize(id)
      @id = id
    end

    def to_hash
      { id: @id }
    end
  end

  def setup
    @entity1 = TestEntity.new(1)
    @entity2 = TestEntity.new(1)
    @entity3 = TestEntity.new(2)
  end

  def test_equals_with_same_id
    assert @entity1.equals(@entity2), 'Entities with the same ID should be equal'
  end

  def test_equals_with_different_id
    refute @entity1.equals(@entity3), 'Entities with different IDs should not be equal'
  end

  def test_equals_with_nil
    refute @entity1.equals(nil), 'Entity should not equal nil'
  end

  def test_equals_with_different_class
    refute @entity1.equals(Object.new), 'Entity should not equal an object of a different class'
  end

  def test_equals_with_no_id
    entity_no_id = TestEntity.new(nil)
    entity_another_no_id = TestEntity.new(nil)
    assert entity_no_id.equals(entity_another_no_id), 'Entities with nil IDs should be equal'
  end

  def test_to_hash
    expected_hash = { id: 1 }
    assert_equal expected_hash, @entity1.to_hash, 'to_hash should return a hash representation of the entity'
  end
end
