require_relative '../config/environment'
DB[:conn] = SQLite3::Database.new ":memory:"

RSpec.configure do |config|
  # Use color not only in STDOUT but also in pagers and files
  config.tty = true 

  #you can do global before/after here like this:
  config.before(:each) do
    if Contact.respond_to?(:create_table)
        Contact.create_table
    else
      DB[:conn].execute("DROP TABLE IF EXISTS contacts")
      DB[:conn].execute("CREATE TABLE IF NOT EXISTS contacts (id INTEGER PRIMARY KEY, firstname TEXT, lastname TEXT, email TEXT, phone TEXT, addresse TEXT, profession TEXT)")
    end
  end

  config.after(:each) do
      DB[:conn].execute("DROP TABLE IF EXISTS contacts")
  end
end
