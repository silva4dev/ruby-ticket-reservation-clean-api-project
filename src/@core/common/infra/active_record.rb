# frozen_string_literal: true

require_relative '../../../../src/database/connection'

module Common
  module Infra
    class ActiveRecord < ActiveRecord::Base
      self.abstract_class = true
    end
  end
end
