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

  describe '.find_by_firstname' do
    it 'returns an array of new contact object by firstname' do
      contact = Contact.create_contact( ["Kevin","Charles","kevindebrincharles@example.com", "21323341", "Cap-Au-Haitien", "Medecin"])

      contact_from_db = Contact.find_by_firstname(contact.firstname)

      expect(contact_from_db[0].id).to eq(contact.id)
    end
  end

  describe '.find_by_id' do
    it 'returns a new contact object by id' do
      contact = Contact.create_contact( ["Kevin","Charles","kevindebrincharles@example.com", "21323341", "Cap-Au-Haitien", "Medecin"])

      contact_from_db = Contact.find_by_id(1)

      expect(contact_from_db.id).to eq(1)
    end
  end

  describe '#delete' do
    it 'returns a new contact object by id' do
      junny.save
      junny.delete
      expect(Contact.find_by_id(junny.id))
      table_check_sql = "SELECT tbl_name FROM sqlite_master WHERE type='table' AND tbl_name='contacts';"
      expect(DB[:conn].execute(table_check_sql)[0]).to eq(nil)

    end
  end

  describe '#delete_all_contact' do
    it 'returns all the contacts info at once' do
      Contact.delete_all_contact
      execute(Contact.all.size).to eq(0)

    end 
  end 

  describe '#update' do
    it 'updates the record associated with a given instance' do
      junny.save
      junny.name = "Johnny"
      junny.update
      junny = Contact.find_by_name("Johnny.")
      expect(junny.id).to eq(junny.id)
    end

  end

end
