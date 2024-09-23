# frozen_string_literal: true

module Common
  module Domain
    module Errors
      class InvalidCpfError < StandardError
        def initialize(message)
          super(message)
        end
      end
    end
  end
end
