# frozen_string_literal: true

require_relative '../../../common/domain/aggregate_root'
require_relative '../../../common/domain/value_objects/uuid_vo'

module Events
  module Domain
    module Entities
      class Partner < Common::Domain::AggregateRoot
        attr_accessor :name

        def initialize(id: nil, name:)
          super()
          @id = id.is_a?(String) ? Common::Domain::ValueObjects::Uuid.new(id) : id || Common::Domain::ValueObjects::Uuid.new
          @name = name
        end

        def self.create(command)
          new(
            name: command[:name]
          )
        end

        def to_hash
          {
            id: @id,
            name: @name
          }
        end
      end
    end
  end
end
