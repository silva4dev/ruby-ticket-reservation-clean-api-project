# frozen_string_literal: true

require_relative '../value_object'
require_relative '../errors/invalid_cpf_error'

module Common
  module Domain
    module ValueObjects
      class Cpf < ValueObject
        attr_reader :value

        def initialize(value)
          super(value)
          @value = value.to_s.gsub(/\D/, '')
          validate
        end

        private

        def validate
          raise Errors::InvalidCpfError, "CPF must have 11 digits, but has #{@value.length} digits" if @value.length != 11

          all_digits_equals = @value =~ /^(\d)\1{10}$/
          raise Errors::InvalidCpfError, 'CPF must have at least two different digits' if all_digits_equals

          first_digit = calculate_digit(@value[0..8], 10)
          second_digit = calculate_digit(@value[0..9], 11)

          raise Errors::InvalidCpfError, 'CPF is invalid' if first_digit != @value[9].to_i || second_digit != @value[10].to_i
        end

        def calculate_digit(base_digits, weight)
          sum = 0
          base_digits.chars.each_with_index do |digit, index|
            sum += digit.to_i * (weight - index)
          end

          digit = 11 - (sum % 11)
          digit > 9 ? 0 : digit
        end
      end
    end
  end
end
