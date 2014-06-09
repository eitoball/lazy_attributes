# encoding: utf-8

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), *%w{ .. lib }))
require 'rspec'
require 'active_record'
require 'logger'
require 'lazy_attributes'

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: ':memory:'
)
ActiveRecord::Base.logger = Logger.new(STDOUT)

class Group < ActiveRecord::Base
  belongs_to :user
end

class User < ActiveRecord::Base
  lazy_attributes :profile
  lazy_attributes :address

  has_many :groups
end

class CreateTables < ActiveRecord::Migration
  def up
    create_table :groups do |t|
      t.references :user
      t.string :name
    end

    create_table :users do |t|
      t.string :name
      t.text :profile
      t.string :address
    end
  end
end

RSpec.configure do |config|
  config.before(:all) do
    CreateTables.new.up unless ActiveRecord::Base.connection.table_exists?('users')
  end

  config.after(:each) do
    User.delete_all
  end
end
