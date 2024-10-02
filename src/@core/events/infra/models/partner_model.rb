# frozen_string_literal: true

require_relative '../../../common/infra/active_record'

module Events
  module Infra
    module Models
      class Partner < Common::Infra::ActiveRecord
        self.table_name = 'partners'
      end
    end
  end
end
