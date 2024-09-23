# frozen_string_literal: true

module Common
  module Domain
    class Entity
      # Entities are domain objects that represent important business concepts. They are responsible for encapsulating
      # the state and behavior related to these concepts, and are fundamental for domain modeling.

      def to_hash
        raise NotImplementedError
      end
    end
  end
end
