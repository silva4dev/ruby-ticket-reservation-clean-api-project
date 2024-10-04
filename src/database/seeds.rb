# frozen_string_literal: true

require_relative '../@core/events/infra/models/partner_model'
require_relative '../@core/common/domain/value_objects/uuid_vo'

Events::Infra::Models::Partner.create!({
  id: Common::Domain::ValueObjects::Uuid.new.value,
  name: 'John Doe'
})

Events::Infra::Models::Partner.create!({
  id: Common::Domain::ValueObjects::Uuid.new.value,
  name: 'Mary Doe'
})
