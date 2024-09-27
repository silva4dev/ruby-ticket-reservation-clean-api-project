# frozen_string_literal: true

require 'set'

require_relative '../../../common/domain/aggregate_root'
require_relative '../../../common/domain/value_objects/uuid_vo'
require_relative '../entities/event_spot_entity'

module Events
  module Domain
    module Entities
      class EventSection < Common::Domain::AggregateRoot
        attr_accessor :name, :description, :is_published, :total_spots, :total_spots_reserved, :price, :spots

        def initialize(id: nil, name:, description: nil, is_published:, total_spots:, total_spots_reserved:, price:, spots: Set.new)
          super()
          @id = id.is_a?(String) ? Common::Domain::ValueObjects::Uuid.new(id) : id || Common::Domain::ValueObjects::Uuid.new
          @name = name
          @description = description || nil
          @is_published = is_published
          @total_spots = total_spots
          @total_spots_reserved = total_spots_reserved
          @price = price
          @spots = spots || Set.new
        end

        def self.create(command)
          section = new(
            name: command[:name],
            description: command[:description],
            is_published: false,
            total_spots: command[:total_spots],
            total_spots_reserved: 0,
            price: command[:price],
            spots: command[:spots]
          )
          section.send(:init_spots)
          section
        end

        def to_hash
          {
            id: @id.value,
            name: @name,
            description: @description,
            is_published: @is_published,
            total_spots: @total_spots,
            total_spots_reserved: @total_spots_reserved,
            price: @price,
            spots: @spots.map(&:to_hash)
          }
        end

        private

        def init_spots
          @total_spots.times do
            @spots.add(EventSpot.create)
          end
        end
      end
    end
  end
end
