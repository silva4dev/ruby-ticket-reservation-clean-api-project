# frozen_string_literal: true

require 'minitest/autorun'
require 'minitest/pride'
require 'database_cleaner/active_record'
require 'dotenv'

Dotenv.load!('.env.test')
