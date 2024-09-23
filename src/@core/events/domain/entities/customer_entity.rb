# frozen_string_literal: true

require_relative '../../../common/domain/aggregate_root'
require_relative '../../../common/domain/value_objects/cpf_vo'

module Events
  module Domain
    module Entities
      class Customer < Common::Domain::AggregateRoot
        attr_accessor :id, :cpf, :name

        def initialize(id: nil, cpf:, name:)
          super()
          @id = id
          @cpf = Common::Domain::ValueObjects::Cpf.new(cpf)
          @name = name
        end

        def self.create(command)
          new(
            cpf: Common::Domain::ValueObjects::Cpf.new(command[:cpf]),
            name: command[:name]
          )
        end

        def to_hash
          {
            id: @id,
            cpf: @cpf,
            name: @name
          }
        end
      end
    end
  end
end
