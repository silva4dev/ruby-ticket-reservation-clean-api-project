# frozen_string_literal: true

require_relative '../../../../test_helper'
require_relative '../../../../../src/@core/events/infra/repositories/partner_mysql_repository'
require_relative '../../../../../src/@core/events/infra/models/partner_model'
require_relative '../../../../../src/@core/events/domain/entities/partner_entity'

class PartnerMysqlRepositoryTest < Minitest::Test
  def setup
    DatabaseCleaner.start
    @partner = Events::Domain::Entities::Partner.create({ name: 'John Doe' })
    @partner_repository = Events::Infra::Repositories::PartnerMysqlRepository.new(
      Events::Infra::Models::Partner
    )
    @partner_repository.add(@partner)
    @sut = @partner_repository.find_by_id(@partner.id.value)
  end

  def teardown
    DatabaseCleaner.clean
  end

  def test_create_new_partner
    assert @sut.id.equals(@partner.id)
  end
end
