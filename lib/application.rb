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

    def self.check_for_contact opt
        system "clear" or system "cls"
        if Contact.all.size == 0
            puts " You have no contact to #{opt} yet","\n","Choose an option:"
            show_option
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
            check_for_contact "see"
            row_header = ["No", "Fullname","Email","Phone number","Address","Profession"]
            contacts = Contact.all.each.with_index(1).map do |person, index|
                ["#{index}.","#{person.firstname} #{person.lastname}", person.email,
                    person.phone, person.address, person.profession]
            end
            # row_table = Contact.show_all_contacts if option == 2
            table = Terminal::Table.new :headings => row_header, :rows => contacts
            table.style = {
                :all_separators => true,:padding_left => 3, 
                :border_x => "=", :border_i => "x"
            }
            puts table
            puts "\n","Choose an option:"
            "show_option"
        when 4
            check_for_contact "edite"
            edit_contact
        when 5
            check_for_contact "delete"
            delete_contact
        when 6
            check_for_contact "edite"
            
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
            inf = gets.strip
            if inf.downcase == "!q"
                # save_contacts(Contact.to_json)
                system "clear" or system "cls"
                return "start"
            end
            info << inf
        end
        #---------------------
        #--------------------------------------check if everything is ok
        while correct.empty?
            system "clear" or system "cls"        
            info.each {|i| print "#{i} \t"}
            puts "\n","Is Everything correct? (y/n)"
            correct = gets.strip.downcase
            if correct != "y" && correct != "n" && correct != "yes" && correct != "no"
                puts "\n", "Bad choice", "\n"
                correct = ""
            end
        end
        #---------------------

        system "clear" or system "cls"
        return "add_contact" if correct == "n" or correct == "no"
        Contact.create_contact info if correct == "y" or correct == "yes"
        puts "Now you have #{Contact.all.size} contact(s)","Choose an option:","\n"
        "show_option"
    end
end

binding.pry