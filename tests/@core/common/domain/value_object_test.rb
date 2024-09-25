# frozen_string_literal: true

require_relative '../../../test_helper'
require_relative '../../../../src/@core/common/domain/value_object'

class ValueObjectTest < Minitest::Test
  class TestValueObject < Common::Domain::ValueObject; end

  def setup
    @value1 = TestValueObject.new("Test Value")
    @value2 = TestValueObject.new("Test Value")
    @value3 = TestValueObject.new("Another Value")
    @value_hash1 = TestValueObject.new({ key: "value" })
    @value_hash2 = TestValueObject.new({ key: "value" })
    @value_hash3 = TestValueObject.new({ key: "different_value" })
    @value_array1 = TestValueObject.new(["element1", "element2"])
    @value_array2 = TestValueObject.new(["element1", "element2"])
    @value_array3 = TestValueObject.new(["element1", "element3"])
  end

  def test_equals_with_same_value
    assert @value1.equals(@value2), "ValueObjects with the same value should be equal"
  end

  def test_equals_with_different_value
    refute @value1.equals(@value3), "ValueObjects with different values should not be equal"
  end

  def test_equals_with_nil
    refute @value1.equals(nil), "ValueObject should not equal nil"
  end

  def test_equals_with_different_class
    refute @value1.equals(Object.new), "ValueObject should not equal an object of a different class"
  end

  def test_equals_with_hash
    assert @value_hash1.equals(@value_hash2), "ValueObjects with the same hash value should be equal"
    refute @value_hash1.equals(@value_hash3), "ValueObjects with different hash values should not be equal"
  end

  def test_equals_with_array
    assert @value_array1.equals(@value_array2), "ValueObjects with the same array value should be equal"
    refute @value_array1.equals(@value_array3), "ValueObjects with different array values should not be equal"
  end
end
