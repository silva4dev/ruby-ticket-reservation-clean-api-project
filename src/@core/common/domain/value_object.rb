# frozen_string_literal: true

module Common
  module Domain
    class ValueObject
      attr_reader :value

      def initialize(value)
        @value = deep_freeze(value)
      end

      def equals(other)
        return false if other.nil?
        return false unless other.is_a?(self.class)
        return false if other.value.nil?

        deep_equal(@value, other.value)
      end

      def to_s
        if !@value.is_a?(Hash) && !@value.is_a?(Array)
          @value.to_s
        else
          @value.to_s == "[object Object]" ? @value.to_json : @value.to_s
        end
      rescue
        @value.to_s
      end

      private

      def deep_freeze(obj)
        case obj
        when Hash
          obj.each { |key, value| deep_freeze(value) }
        when Array
          obj.each { |element| deep_freeze(element) }
        end
        obj.freeze
      end

      def deep_equal(value1, value2)
        if value1.is_a?(Hash) && value2.is_a?(Hash)
          return false unless value1.keys == value2.keys
          value1.all? { |key, val| deep_equal(val, value2[key]) }
        elsif value1.is_a?(Array) && value2.is_a?(Array)
          return false unless value1.size == value2.size
          value1.each_with_index.all? { |val, idx| deep_equal(val, value2[idx]) }
        else
          value1 == value2
        end
      end
    end
  end
end