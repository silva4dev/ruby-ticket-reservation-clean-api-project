# frozen_string_literal: true

require 'set'

require_relative '../../../common/domain/aggregate_root'
require_relative '../../../common/domain/value_objects/uuid_vo'
require_relative '../entities/event_section_entity'

module Events
  module Domain
    module Entities
      class Event < Common::Domain::AggregateRoot
        attr_accessor :name, :description, :date, :is_published, :total_spots, :total_spots_reserved, :partner_id, :sections

        def initialize(id: nil, name:, description: nil, date:, is_published:, total_spots:, total_spots_reserved:, partner_id:, sections: Set.new)
          super()
          @id = id.is_a?(String) ? Common::Domain::ValueObjects::Uuid.new(id) : id || Common::Domain::ValueObjects::Uuid.new
          @name = name
          @description = description || nil
          @date = date
          @is_published = is_published
          @total_spots = total_spots
          @total_spots_reserved = total_spots_reserved
          @partner_id = partner_id.is_a?(String) ? Common::Domain::ValueObjects::Uuid.new(partner_id) : partner_id
          @sections = sections || Set.new
        end

        def self.create(command)
          new(
            name: command[:name],
            description: command[:description],
            date: command[:date],
            is_published: false,
            total_spots: 0,
            total_spots_reserved: 0,
            partner_id: Common::Domain::ValueObjects::Uuid.new(command[:partner_id]),
            sections: command[:sections]
          )
        end

        def add_section(command)
          section = EventSection.create({
            id: command.id,
            name: command.name,
            description: command.description,
            is_published: command.is_published,
            total_spots: command.total_spots,
            total_spots_reserved: command.total_spots_reserved,
            price: command.price,
            spots: command.spots
          })
          @sections.add(section)
          @total_spots += section.total_spots
        end

        def to_hash
          {
            id: @id.value,
            name: @name,
            description: @description,
            date: @date,
            is_published: @is_published,
            total_spots: @total_spots,
            total_spots_reserved: @total_spots_reserved,
            partner_id: @partner_id.value,
            sections: @sections.map(&:to_hash)
          }
        end
      end
    end
  end
end
