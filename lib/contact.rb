require 'pry'
class Contact
    attr_accessor :firstname, :lastname, :email, :phone, :address, :profession
    attr_reader :id
     
    def initialize(id=nil, firstname, lastname, email, phone, address, profession)
    @id = id
    @firtsname = firstname
    @lastname = lastname
    @email = email
    @phone = phone
    @address = address
    @profession = profession
    end
     
    def self.create_table
    sql = <<-SQL
    CREATE TABLE IF NOT EXISTS contacts (
    id INTEGER PRIMARY KEY,
    firstname TEXT,
    lastname TEXT,
    email TEXT,
    phone TEXT,
    addresse TEXT,
    profession TEXT
    )
    SQL
    DB[:conn].execute(sql)
    end
    
    def self.drop_table
        sql = <<-SQL
          DROP TABLE contacts
        SQL
        DB[:conn].execute(sql)
      end
    
      def self.new_from_db(row)
        id = row[0]
        firstname = row[1]
        lastname = row[2]
        email = [3]
        phone = [4]
        address = [5]
        profession = [6]

        new_contact = Contact.new(id: id, firstname: firstname, lastname: lastname, email: email, phone: phone,  address: address, profession: profession)
      end

      def self.find_by_firstname(firstname)
        sql = <<-SQL
          SELECT *
          FROM contacts
          WHERE firstname = ?
          LIMIT 1
        SQL
        DB[:conn].execute(sql, firstname).map do |row|
          self.new_from_db(row)
        end.first
      end

      def self.find_by_lastname(lastname)
        sql = <<-SQL
          SELECT *
          FROM contacts
          WHERE lastname = ?
          LIMIT 1
        SQL
        DB[:conn].execute(sql, lastname).map do |row|
          self.new_from_db(row)
        end.first
      end

      def update
        sql = <<-SQL
          UPDATE contacts
          SET firstname = ?, lastname = ?, email = ?, phone = ?, addresse = ?, profession = ?
          WHERE id = ?
        SQL
        DB[:conn].execute(sql, self.firstname, self.lastname, self.emaail, self.phone, self.address, self.profession, self.id)
      end


end 
    binding.pry