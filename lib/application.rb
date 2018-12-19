class Application
    ADDCONTACTSTAPE = [
        "Enter the firstname","Enter the lastname",
        "Enter the email","Enter the address","Enter the phone number", "Enter the profession"]
    EDITCONTACTSTAPE = [
        "Enter the new firstname","Enter the new lastname",
        "Enter the new email","Enter the new address",
        "Enter the new phone number","Enter the new profession"]
    CHOICES = [
        "1. Add a contact", "2. Show contacts asc", 
        "3.Find contact by firstname" "4. Edit a contact", 
        "5. Delete a contact", "6. Delete all contacts", "7. Exit to My_contact", "\n"]

    def self.welcome
        puts "\t\t--------- Welcome to My_Contact ---------"
    end
end