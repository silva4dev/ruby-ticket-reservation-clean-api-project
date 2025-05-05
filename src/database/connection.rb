# frozen_string_literal: true

require 'active_record'
require 'mysql2'
require 'yaml'
require 'logger'
require 'dotenv'

if ENV['RACK_ENV'] == 'test'
  Dotenv.load!('.env.test')
else
  Dotenv.load!('.env.development')
end

environment = ENV['RACK_ENV'].to_sym
config_path = File.join(__dir__, 'database.yml')
ActiveRecord::Base.configurations = YAML.load_file(config_path)
ActiveRecord::Base.establish_connection(environment)

logger = Logger.new(STDOUT)
logger.formatter = proc do |severity, datetime, progname, msg|
  "#{msg}\n"
end

ActiveRecord::Base.logger = logger
