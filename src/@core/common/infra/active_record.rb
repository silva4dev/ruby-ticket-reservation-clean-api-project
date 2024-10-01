# frozen_string_literal: true

require_relative '../../../../src/config/active_record'

module Common
  module Infra
    class ActiveRecord < ActiveRecord::Base
      self.abstract_class = true
    end
  end
end
