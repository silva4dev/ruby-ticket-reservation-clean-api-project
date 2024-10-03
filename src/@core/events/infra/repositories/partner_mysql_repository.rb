# frozen_string_literal: true

require_relative '../../domain/repositories/partner_repository'
require_relative '../mappers/partner_mapper'

module Events
  module Infra
    module Repositories
      class PartnerMysqlRepository < Domain::Repositories::PartnerRepository
        def initialize(partner_persistence)
          super()
          @partner_persistence = partner_persistence
        end

        def add(entity)
          @partner_persistence.create!(to_dao(entity))
        end

        def find_by_id(id)
          to_entity(@partner_persistence.find(id))
        end

        def find_all
          @partner_persistence.all.map { |entity| to_entity(entity) }
        end

        def delete(entity)
          @partner_persistence.find(entity.id).destroy
        end

        private

        def to_entity(dao)
          Mappers::PartnerMapper.to_entity(dao)
        end

        def to_dao(entity)
          Mappers::PartnerMapper.to_dao(entity)
        end
      end
    end
  end
end
