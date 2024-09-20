# frozen_string_literal: true

module Common
  module Domain
    class Entity
      private_class_method :new

      def to_hash
        raise NotImplementedError
      end
    end
  end
end
