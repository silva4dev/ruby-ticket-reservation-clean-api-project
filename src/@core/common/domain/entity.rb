# frozen_string_literal: true

module Common
  module Domain
    class Entity
      def to_hash
        raise NotImplementedError
      end
    end
  end
end
