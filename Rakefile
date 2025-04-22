# frozen_string_literal: true

require_relative 'src/database/connection'

namespace :db do
  desc 'Migrate the database (options: VERSION=x).'
  task :migrate do
    environment = ENV['ENVIRONMENT'] || 'development'
    config = ActiveRecord::Base.configurations.configs_for(env_name: environment).first
    ActiveRecord::Base.establish_connection(config.configuration_hash)
    migrations_paths = './src/database/migrations'
    ActiveRecord::Migration.verbose = true
    version = ENV['VERSION'] ? ENV['VERSION'].to_i : nil
    migration_context = ActiveRecord::MigrationContext.new(migrations_paths)
    migration_context.migrate(version)
    Rake::Task['db:schema:dump'].invoke
  end

  desc 'Retrieves the current schema version number for the specified environment.'
  task :version do
    environment = ENV['ENVIRONMENT'] || 'development'
    config = ActiveRecord::Base.configurations.configs_for(env_name: environment).first
    if config
      ActiveRecord::Base.establish_connection(config.configuration_hash)
      current_version = ActiveRecord::Migrator.current_version
      puts "Current version for the '#{environment}' environment: #{current_version}"
    else
      puts "Database configuration not found for environment '#{environment}'!"
    end
  end

  desc 'Populate the database.'
  task :seed do
    environment = ENV['ENVIRONMENT'] || 'development'
    config = ActiveRecord::Base.configurations.configs_for(env_name: environment).first
    ActiveRecord::Base.establish_connection(config.configuration_hash)
    require './src/database/seeds'
    puts "Database seeded successfully for environment: #{environment}."
  end

  desc 'Gives you a timestamp for your migration file name.'
  task :timestamp do
    puts DateTime.now.strftime('%Y%m%d%H%M%S')
  end

  desc 'Create the database.'
  task :create do
    environment = ENV['ENVIRONMENT'] || 'development'
    config = ActiveRecord::Base.configurations.configs_for(env_name: environment).first
    if config && config.configuration_hash[:database]
      begin
        ActiveRecord::Base.establish_connection(config.configuration_hash.merge('database' => nil))
        ActiveRecord::Base.connection.create_database(config.configuration_hash[:database])
        puts "Database '#{config.configuration_hash[:database]}' created successfully."
      rescue ActiveRecord::StatementInvalid => e
        puts "Database creation failed: #{e.message}"
      end
    else
      puts "Database configuration not found for environment '#{environment}'!"
    end
  end

  desc 'Drop the database.'
  task :drop do
    environment = ENV['ENVIRONMENT'] || 'development'
    config = ActiveRecord::Base.configurations.configs_for(env_name: environment).first
    if config && config.configuration_hash[:database]
      begin
        ActiveRecord::Base.establish_connection(config.configuration_hash.merge('database' => nil))
        ActiveRecord::Base.connection.drop_database(config.configuration_hash[:database])
        puts "Database '#{config.configuration_hash[:database]}' dropped successfully."
      rescue ActiveRecord::StatementInvalid => e
        puts "Database drop failed: #{e.message}"
      end
    else
      puts "Database configuration not found for environment '#{environment}'!"
    end
  end

  desc 'Setup the database: drop, create, migrate and seed.'
  task :setup do
    environment = ENV['ENVIRONMENT'] || 'development'
    config = ActiveRecord::Base.configurations.configs_for(env_name: environment).first
    ActiveRecord::Base.establish_connection(config.configuration_hash)
    Rake::Task['db:drop'].invoke
    Rake::Task['db:create'].invoke
    Rake::Task['db:migrate'].invoke
    puts 'Database setup complete.'
  end

  namespace :schema do
    desc 'Generate the database schema.'
    task :dump do
      require 'active_record/schema_dumper'
      environment = ENV['ENVIRONMENT'] || 'development'
      filename = "./src/database/schema_#{environment}.rb"
      File.open(filename, 'w:utf-8') do |file|
        ActiveRecord::SchemaDumper.dump(ActiveRecord::Base.connection, file)
      end
      puts "Schema dumped to #{filename} for the '#{environment}' environment."
    end
  end

  namespace :generate do
    desc 'Generate a new migration with the provided name.'
    task :migration, [:name] do |_t, args|
      unless args[:name]
        puts 'Please provide a name for the migration.'
        next
      end

      database_path = './src/database'
      Dir.mkdir(database_path) unless Dir.exist?(database_path)

      migration_path = "#{database_path}/migrations"
      Dir.mkdir(migration_path) unless Dir.exist?(migration_path)

      migration_name = args[:name].tr(' ', '_')
      timestamp = Time.now.strftime('%Y%m%d%H%M%S')
      migration_filename = "#{migration_path}/#{timestamp}_#{migration_name}.rb"

      File.open(migration_filename, 'w') do |file|
        class_name = migration_name.split('_').map(&:capitalize).join
        migration_version = ActiveRecord::Migration.current_version

        file.write <<~MIGRATION
          # frozen_string_literal: true

          class #{class_name} < ActiveRecord::Migration[#{migration_version}]
            def change
              # Add your changes here
            end
          end
        MIGRATION
      end

      puts "Migration created: #{migration_filename}"
    end
  end
end
