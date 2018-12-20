class Application
    ADDCONTACTSTAPE = [
        "Enter the firstname","Enter the lastname",
        "Enter the email","Enter the address","Enter the phone number", "Enter the profession"]
    EDITCONTACTSTAPE = [
        "Enter the new firstname","Enter the new lastname",
        "Enter the new email","Enter the new address",
        "Enter the new phone number","Enter the new profession"]
    CHOICES = [
        ["1. Add a contact", "2. Show contacts asc" ],
        ["3.Find contact by firstname", "4. Edit a contact"], 
        ["5. Delete a contact", "6. Delete all contacts"], ["7. Exit to My_contact", "\n"]]

    def self.welcome
        puts "\t\t--------- Welcome to My_Contact ---------","\n"
        Contact.create_table
    end

    def self.start
        puts "You have #{Contact.all.size} contact(s)","** You can type !q to back to the menu **"
        puts "-----------------------------------------------","Choose an option:"
        "show_option"
    end

    def self.show_option
        #----------------------------------Menu show
        table = Terminal::Table.new :title => "Menu", :rows => CHOICES
        table.style = {
            :all_separators => true,:padding_left => 3, 
            :border_x => "=", :border_i => "x"
        }
        puts table

        option = gets.strip.to_i

        while option <= 0 || option > 7
            system "clear" or system "cls"
            puts "Option out of range", "Please choose an option:"
            puts table
            option = gets.strip.to_i
        end
        #-------------------

        case option
        when 1
            system "clear" or system "cls"
            add_contact
        when 0 , 7
            puts "Do you really want to exit (Y/N)"
            exi = gets.strip.downcase
            if exi == "n" or exi == "no"
                return "start"
            end
            puts "Byeeeeeee"
            "exit"
        end
        
    end
end

binding.pry