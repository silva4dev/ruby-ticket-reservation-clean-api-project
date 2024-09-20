# frozen_string_literal: true

require_relative './entity'

module Common
  module Domain
    class AggregateRoot < Entity
      private_class_method :new
    end
  end
end