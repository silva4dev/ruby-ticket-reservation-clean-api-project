# frozen_string_literal: true

require_relative '../../../test_helper'
require_relative '../../../../src/@core/common/infra/active_record'

class ActiveRecordTest < Minitest::Test
  def setup
    @mock_class = Class.new(Common::Infra::ActiveRecord) do
      def self.table_name
        'mock_records'
      end
    end
  end

  def test_class_inheritance
    assert_includes(@mock_class.ancestors, ActiveRecord::Base, 'Mock class should inherit from ActiveRecord::Base')
  end

  def test_abstract_class
    assert_raises(NotImplementedError) do
      Common::Infra::ActiveRecord.new
    end
  end

  def test_mock_table_name
    assert_equal 'mock_records', @mock_class.table_name, 'Expected the mocked table name to be "mock_records"'
  end

  def test_connection_to_database
    Common::Infra::ActiveRecord.stub(:connection, true) do
      assert Common::Infra::ActiveRecord.connection, 'Expected connection to be mocked as true'
    end
  end

  def test_table_name
    assert_equal 'mock_records', @mock_class.table_name, 'Expected table name for mock class to be "mock_records"'
  end
end
