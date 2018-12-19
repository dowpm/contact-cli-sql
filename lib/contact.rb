
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
    
    def self.new_from_db(row)
      id = row[0]
      firstname = row[1]
      lastname = row[2]
      email = [3]
      phone = [4]
      address = [5]
      profession = [6]
      
      new(id, firstname, lastname, email, phone,  address, profession)
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

    def self.all
      sql = <<-SQL
        SELECT *
        FROM contacts ORDER BY firstname
      SQL
      DB[:conn].execute(sql).map do |row|
        self.new_from_db(row)
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

    def delete_all_contact
      sql = <<-SQL
      delete FROM contacts
      SQL
      DB[:conn].execute(sql)
    end 

end 
    # binding.pry