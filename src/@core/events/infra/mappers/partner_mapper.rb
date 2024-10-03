# frozen_string_literal: true

require_relative '../../domain/entities/partner_entity'
require_relative '../../../common/domain/value_objects/uuid_vo'
require_relative '../../../common/infra/mapper'

module Events
  module Infra
    module Mappers
      class PartnerMapper < Common::Infra::Mapper
        def self.to_entity(dao)
          Domain::Entities::Partner.new(
            id: dao[:id].is_a?(String) ? Common::Domain::ValueObjects::Uuid.new(dao[:id]) : dao[:id],
            name: dao[:name]
          )
        end

        def self.to_dao(entity)
          {
            id: entity.id.value,
            name: entity.name
          }
        end
      end
    end
  end
end
