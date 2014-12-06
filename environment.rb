require 'mongo_mapper'
require 'pry'
require 'csv'
require 'sidekiq'
require 'twitter'
Dir[File.dirname(__FILE__) + '/extensions/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/models/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/workers/*.rb'].each {|file| require file }
MongoMapper.connection = Mongo::MongoClient.new("24.61.9.153", :pool_size => 25, :pool_timeout => 60)
MongoMapper.database = "ea1_pbsds"
