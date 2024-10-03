# frozen_string_literal: true

module Common
  module Domain
    class Entity
      # Entities are domain objects that represent important business concepts.
      # They are responsible for encapsulating the state and behavior related to these concepts,
      # and are fundamental for domain modeling.

      attr_reader :id

      def to_hash
        raise NotImplementedError
      end

      def equals(other)
        return false if other.nil?
        return false unless other.respond_to?(:id)
        return false unless other.instance_of?(self.class)

        other.id.to_s == id.to_s
      end
    end
  end
end
