# frozen_string_literal: true

module Common
  module Domain
    class Repository
      def add(entity)
        raise NotImplementedError
      end

      def find_by_id(id)
        raise NotImplementedError
      end

      def find_all
        raise NotImplementedError
      end

      def delete(entity)
        raise NotImplementedError
      end
    end
  end
end
