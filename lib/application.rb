require_relative 'contact'
class Application
    ADDCONTACTSTAPE = [
        "Enter the firstname","Enter the lastname",
        "Enter the email","Enter the phone number",
        "Enter the address", "Enter the profession"]
    EDITCONTACTSTAPE = [
        "Enter the new firstname","Enter the new lastname",
        "Enter the new email","Enter the new phone number",
        "Enter the new address","Enter the new profession"]
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

    def self.check_for_contact? opt
        system "clear" or system "cls"
        if Contact.all.size == 0
            puts " You have no contact to #{opt} yet","\n","Choose an option:"
            true
            else
                false
        end
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
        when 2
            return 'show_option' if check_for_contact? "see"
            row_header = ["No", "Fullname","Email","Phone number","Address","Profession"]

            contacts = Contact.all.each.with_index(1).map do |person, index|
                ["#{index}.","#{person.firstname} #{person.lastname}", person.email,
                    person.phone, person.address, person.profession]
            end
            table = Terminal::Table.new :headings => row_header, :rows => contacts
            table.style = {
                :all_separators => true,:padding_left => 3, 
                :border_x => "=", :border_i => "x"
            }
            puts table
            puts "\n","Choose an option:"
            "show_option"
        when 3
            return 'show_option' if check_for_contact? "find"
            # edit_contact
        when 4
            check_for_contact? "edite"
            edit_contact
        when 5
            check_for_contact? "delete"
            delete_contact
        when 6
            check_for_contact? "edite"
            
        when 7
            puts "Do you really want to exit (y/n)"
            exi = gets.strip.downcase
            if exi == "n" or exi == "no"
                return "start"
            end
            puts "Byeeeeeee"
            "exit"
        end
        
    end

    def self.add_contact
        #--------------------------------------get info to save contact
        info, correct = [], ""
        ADDCONTACTSTAPE.each do |stape|
            puts "\n",stape
            stape.include?('firstname') || stape.include?('lastname') ? 
            inf = gets.strip.capitalize : inf = gets.strip
            if inf.downcase == "!q"
                # save_contacts(Contact.to_json)
                system "clear" or system "cls"
                return "start"
            end
            info << inf
        end
        #---------------------
        system "clear" or system "cls" 
        #--------------------------------------check if all info is ok
        while correct.empty?
                   
            info.each {|i| print "#{i} \t"}
            puts "\n","Is Everything correct? (y/n)"
            correct = gets.strip.downcase
            if correct != "y" && correct != "n" && correct != "yes" && correct != "no"
                system "clear" or system "cls" 
                puts "\n", "Bad choice", "\n"
                correct = ""
            end
        end
        #---------------------

        system "clear" or system "cls"
        if correct == "n" or correct == "no"
            return "add_contact" 
        else
            contact = Contact.create_contact info
            puts "#{contact.firstname} #{contact.lastname} has been successfully added to your contact\n"
            puts "Now you have #{Contact.all.size} contact(s)","Choose an option:","\n"
            "show_option"
        end
    end

    def self.edit_contact
        info, correct = [], ""
        
        puts "Choose the contact to edite:","** You can type '!q' to back to the menu **"
        puts "** You can hit enter to keep the old information **"
        contacts = Contact.all.each.with_index(1).map do |person, index|
            "#{index}. #{person.firstname} #{person.lastname}"
        end.join("\n")
        puts contacts

        index = gets.strip
        if index.upcase == "!Q"
            return "start"
        end

        index = index.to_i
        if index < 1 or index > (Contact.all.size)
            system "clear" or system "cls"
            return "edit_contact"
        end
        contact = Contact.all[index-1]
        data = [contact.firstname, contact.lastname,
        contact.email, contact.phone, contact.address,
        contact.profession]
        EDITCONTACTSTAPE.each.with_index do |stape, i|
            
            puts "#{stape} for (#{data[i]})"
            stape.include?('firstname') || stape.include?('lastname') ? 
            inf = gets.strip.capitalize : inf = gets.strip
            return "start" if inf.upcase == "!Q"
            if inf == ""
                info << data[i]
            else
                info << inf
            end
        end
        #--------------------------------------check if all info is ok
        while correct.empty?
            system "clear" or system "cls"
            info.each {|i| print "#{i} \t"}
            puts "\n","Is Everything correct? (Y/N)"
            correct = gets.strip.upcase
            if correct != "Y" && correct != "N" && correct != "YES" && correct != "NO"
                puts "\n", "Bad choice", "\n"
                correct = ""
            end
        end
        #-----------------------
        system "clear" or system "cls"
        if correct == "N" or correct == "NO"
            system "clear" or system "cls"
            edit_contact
        else
            info.unshift contact.id
            contact = Contact.create_contact info
            puts "#{contact.firstname} #{contact.lastname} has been successfully edited \n"
            puts "Choose an option:","\n"
            "show_option"
        end        
    end

    def self.delete_contact
        puts "Choose the contact to delete:","** You can type !q to back to the menu **"
        contacts = Contact.all.each.with_index(1).map do |person, index|
            "#{index}. #{person.firstname} #{person.lastname}"
        end.join("\n")
        puts contacts
        index = gets.strip
        if index.upcase == "!Q"
            return "start"
        end
        index = index.to_i
        if index < 1 or index > Contact.all.size
            system "cls" or system "clear"
            return "delete_contact"
        end
        puts "Are you sure? (Y/N)"
        ch = gets.strip.upcase
        if ch == "N" or ch == "NO"
            return "start"
        end
        system "clear" or system "cls"
        contact = Contact.all[index-1]
        contact.delete
        puts "#{contact.firstname} #{contact.lastname} has been deleted","\n","Choose an option:"
        "show_option"
    end

    def self.print_contacts(from_number)
      
        rows = Contact.all[from_number-1, 10].each.with_index(from_number).map do |person, index|
            ["#{index}.","#{person.firstname} #{person.lastname}", person.email,
                person.phone, person.address, person.profession]
        end
        row_header = ["No", "Fullname","Email","Phone number","Address","Profession"]
        table = Terminal::Table.new :title => "Contacts #{from_number} - #{from_number+9}",
         :headings => row_header, :rows => rows
        
        table.style = {
                        :all_separators => true,:padding_left => 3, 
                        :border_x => "=", :border_i => "x"
                    }
        puts table
  end
end

binding.pry