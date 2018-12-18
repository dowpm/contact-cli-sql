require_relative "spec_helper"

describe "Contact" do

  let(:junny) {Contact.new( "Johnny", "Pierre", "johnnypierre@example.com", "44000000", "Downtown", "Lawyer" )}

  before(:each) do
    DB[:conn].execute("DROP TABLE IF EXISTS contacts")
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

  describe "attributes" do
    it 'has a firstname, lastname, email, phone, address and a profession' do
      # contact = Contact.new(firstname: "Mack", "Dowell", email: mackdowell@noukod.com, phone:"44443321", addresse: "downtown", profession: "programmer")
      contact = Contact.new("Mack", "Dowell", "mackdowell@noukod.com", "44443321",  "Downtown", "Programmer")

      expect(contact.firstname).to eq("Mack")
      expect(contact.lastname).to eq("Dowell")
      expect(contact.email).to eq("mackdowell@noukod.com")
      expect(contact.phone).to eq("44443321")
      expect(contact.address).to eq("Downtown")
      expect(contact.profession).to eq("Programmer")
    end

    it 'has an id that defaults to `nil` on initialization' do
      expect(junny.id).to eq(nil)
    end
  end

  describe ".create_table" do
    it 'creates the contacts table in the database' do
      DB[:conn].execute("DROP TABLE IF EXISTS contacts")
      Contact.create_table
      table_check_sql = "SELECT tbl_name FROM sqlite_master WHERE type='table' AND tbl_name='contacts';"
      expect(DB[:conn].execute(table_check_sql)[0]).to eq(['contacts'])
    end
  end

  describe "#save" do
    it 'returns an instance of the contact class' do
      contact = junny.save

      expect(contact).to be_instance_of(Contact)
    end

    it 'saves an instance of the contact class to the database and then sets the given contacts `id` attribute' do
      contact = junny.save

      expect(DB[:conn].execute("SELECT * FROM contacts WHERE id = 1")).to eq([[1, "Johnny", "Pierre", "johnnypierre@example.com", "44000000", "Downtown", "Lawyer" ]])
      expect(contact.id).to eq(1)
    end
  end

  # describe ".create" do
  #   it 'takes in a hash of attributes and uses metaprogramming to create a new contact object. Then it uses the #save method to save that contact to the database'do
  #     Contact.create(name: "Ralph", breed: "lab")
  #     expect(DB[:conn].execute("SELECT * FROM contacts")).to eq([[1, "Ralph", "lab"]])
  #   end
  #   it 'returns a new dog object' do
  #     contact = Contact.create(name: "Dave", breed: "podle")

  #     expect(teddy).to be_an_instance_of(Dog)
  #     expect(dog.name).to eq("Dave")
  #   end
  # end

  



end
