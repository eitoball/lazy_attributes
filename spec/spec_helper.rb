# encoding: utf-8

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), *%w{ .. lib }))
require 'rspec'
require 'active_record'
require 'lazy_attributes'
require 'database_cleaner'

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: ':memory:'
)
ActiveRecord::Base.logger = Logger.new(STDOUT)

class User < ActiveRecord::Base
end

class CreateTables < ActiveRecord::Migration
  def up
    create_table :users do |t|
      t.string :name
      t.text :profile
      t.string :address
    end
  end
end

RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:all) do
    CreateTables.new.up unless ActiveRecord::Base.connection.table_exists?('users')
  end

  config.after(:each) do
    User.delete_all
  end
end
