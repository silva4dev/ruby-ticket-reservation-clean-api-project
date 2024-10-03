# frozen_string_literal: true

require_relative '../../../test_helper'
require_relative '../../../../src/@core/common/domain/aggregate_root'

class AggregateRootTest < Minitest::Test
  class TestAggregateRoot < Common::Domain::AggregateRoot
    attr_reader :id

    def initialize(id)
      super()
      @id = id
    end

    def to_hash
      { id: @id }
    end
  end

  def setup
    @aggregate1 = TestAggregateRoot.new(1)
    @aggregate2 = TestAggregateRoot.new(1)
    @aggregate3 = TestAggregateRoot.new(2)
  end

  def test_initialization
    assert_instance_of TestAggregateRoot, @aggregate1, 'Should create an instance of TestAggregateRoot'
  end

  def test_equals_with_same_id
    assert @aggregate1.equals(@aggregate2), 'AggregateRoots with the same ID should be equal'
  end

  def test_equals_with_different_id
    refute @aggregate1.equals(@aggregate3), 'AggregateRoots with different IDs should not be equal'
  end

  def test_equals_with_nil
    refute @aggregate1.equals(nil), 'AggregateRoot should not equal nil'
  end

  def test_equals_with_different_class
    refute @aggregate1.equals(Object.new), 'AggregateRoot should not equal an object of a different class'
  end

  def test_to_hash
    expected_hash = { id: 1 }

    assert_equal expected_hash, @aggregate1.to_hash, 'to_hash should return a hash representation of the aggregate'
  end
end
