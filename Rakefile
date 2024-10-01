# frozen_string_literal: true

require_relative './src/config/active_record'

namespace :db do
  desc 'Migrate the database (options: VERSION=x).'
  task :migrate do
    migrations_paths = './src/database/migrate'
    ActiveRecord::Migration.verbose = true
    version = ENV['VERSION'] ? ENV['VERSION'].to_i : nil
    migration_context = ActiveRecord::MigrationContext.new(migrations_paths)
    migration_context.migrate(version)
    Rake::Task["db:schema:dump"].invoke
  end

  desc 'Retrieves the current schema version number.'
  task :version do
    puts "Current version: #{ActiveRecord::Migrator.current_version}"
  end

  desc 'Populate the database with sample data.'
  task :seed do
    require './src/database/seeds.rb'
  end

  desc 'Gives you a timestamp for your migration file name.'
  task :timestamp do
    puts DateTime.now.strftime('%Y%m%d%H%M%S')
  end

  namespace :schema do
    desc 'Create a db/schema.rb file that can be portably used against any DB supported by AR.'
    task :dump do
      require 'active_record/schema_dumper'
      filename = './src/database/schema.rb'

      File.open(filename, "w:utf-8") do |file|
        ActiveRecord::SchemaDumper.dump(ActiveRecord::Base.connection, file)
      end
    end
  end

  namespace :generate do
    desc 'Generate a new migration with the provided name.'
    task :migration, [:name] do |_t, args|
      unless args[:name]
        puts "Please provide a name for the migration."
        next
      end

      database_path = './src/database'
      Dir.mkdir(database_path) unless Dir.exist?(database_path)

      migration_path = "#{database_path}/migrate"
      Dir.mkdir(migration_path) unless Dir.exist?(migration_path)

      migration_name = args[:name].gsub(' ', '_')
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
