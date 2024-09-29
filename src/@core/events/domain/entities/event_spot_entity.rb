# frozen_string_literal: true

require_relative '../../../common/domain/aggregate_root'
require_relative '../../../common/domain/value_objects/uuid_vo'

module Events
  module Domain
    module Entities
      class EventSpot < Common::Domain::AggregateRoot
        attr_reader :location, :is_reserved, :is_published

        def initialize(id: nil, location:, is_reserved:, is_published: false)
          super()
          @id = id.is_a?(String) ? Common::Domain::ValueObjects::Uuid.new(id) : id || Common::Domain::ValueObjects::Uuid.new
          @location = location || nil
          @is_reserved = is_reserved
          @is_published = is_published || false
        end

        def self.create
          new(
            location: nil,
            is_reserved: false,
            is_published: false
          )
        end

        def change_location(location)
          @location = location
        end

        def publish
          @is_published = true
        end

        def unpublish
          @is_published = false
        end

        def to_hash
          {
            id: @id.value,
            location: @location,
            is_reserved: @is_reserved,
            is_published: @is_published
          }
        end
      end
    end
  end
end
