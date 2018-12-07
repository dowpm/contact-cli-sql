require 'sqlite3'

DB = {:conn => SQLite3::Database.new("db/contacts.db")}#// the connection of our database

DB[:conn].execute("DROP TABLE IF EXISTS contacts") #// drop contacts to avoid error

require_relative '../lib/contact.rb'