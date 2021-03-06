
class Contact
    attr_accessor :firstname, :lastname, :email, :phone, :address, :profession
    attr_reader :id

    def initialize(id=nil, firstname, lastname, email, phone, address, profession)
      @id = id
      @firstname = firstname
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
    
    def self.create_contact(row)
        new(*row).tap { |c| c.save}
    end

    def self.find_by_firstname(firstname)
      sql = <<-SQL
        SELECT *
        FROM contacts
        WHERE firstname LIKE ?
      SQL
      DB[:conn].execute(sql, firstname+"%").map do |row|
        new(*row)
      end
    end

    def self.find_by_id(id)
      sql = <<-SQL
        SELECT *
        FROM contacts
        WHERE id = ?
        LIMIT 1
      SQL
      DB[:conn].execute(sql, id).map do |row|
        new(*row)
      end.first
    end
    
    def self.find_by_phone(phone)
      sql = <<-SQL
        SELECT *
        FROM contacts
        WHERE phone LIKE ?
      SQL
      DB[:conn].execute(sql, phone+'%').map do |row|
        new(*row)
      end
    end

    def self.all
      sql = <<-SQL
        SELECT *
        FROM contacts ORDER BY firstname
      SQL
      DB[:conn].execute(sql).map do |row|
        self.new(*row)
      end
    end

    def update
      sql = <<-SQL
        UPDATE contacts
        SET firstname = ?, lastname = ?, email = ?, phone = ?, addresse = ?, profession = ?
        WHERE id = ?
      SQL
      DB[:conn].execute(sql, self.firstname, self.lastname, self.email, self.phone, self.address, self.profession, self.id)
    end

    def save
      if self.id
        self.update
      else
        sql = <<-SQL
          INSERT INTO contacts (firstname, lastname, email, phone, addresse, profession)
          VALUES (?, ?, ?, ?, ?, ?)
        SQL
        DB[:conn].execute(sql, self.firstname, self.lastname, self.email, self.phone, self.address, self.profession)
  
        @id = DB[:conn].execute('SELECT last_insert_rowid() FROM contacts')[0][0]
      end
      self
    end
  
    def delete
      sql = <<-SQL
      delete FROM contacts WHERE id = ?
      SQL
      DB[:conn].execute(sql, self.id)

    end 

    def self.delete_all_contact
      sql = <<-SQL
      delete FROM contacts
      SQL
      DB[:conn].execute(sql)
    end 

end 
    # binding.pry 
