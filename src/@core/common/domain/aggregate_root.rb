# frozen_string_literal: true

require_relative 'entity'

module Common
  module Domain
    class AggregateRoot < Entity
      # An aggregate is a set of domain objects that are treated as a cohesive unit.
      # They are used to delimit consistent state change transactions within the domain.
    end
  end
end
