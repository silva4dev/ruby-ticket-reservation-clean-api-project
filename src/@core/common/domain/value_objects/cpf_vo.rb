# frozen_string_literal: true

require_relative '../value_object'

module Common
  module Domain
    module ValueObjects
      class Cpf < ValueObject
        attr_reader :value

        def initialize(value)
          @value = value.gsub(/\D/, '')
          validate
        end

        private

        def validate
          raise StandardError, "CPF must have 11 digits, but has #{@value.length} digits" if @value.length != 11

          raise StandardError, 'CPF must have at least two different digits' if @value.match?(/^(\d)\1{10}$/)

          first_digit = calculate_digit(@value[0, 9], 10)
          second_digit = calculate_digit(@value[0, 10], 11)

          unless first_digit == @value[9].to_i && second_digit == @value[10].to_i
            raise StandardError, 'CPF is invalid'
          end
        end

        def calculate_digit(digits, multiplier)
          sum = digits.chars.each_with_index.sum do |digit, index|
            digit.to_i * (multiplier - index)
          end

          result = 11 - (sum % 11)
          result > 9 ? 0 : result
        end
      end
    end
  end
end
