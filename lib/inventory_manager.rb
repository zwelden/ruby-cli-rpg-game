require 'helpers/utilities'
require 'ui/display'

class InventoryManager 
    def self.manage_inventory(player)

        action = ""
        while (handle_next_inventory_action(action, player))
            system "clear"
            player.show_full_detail() 
            action = self.get_next_action()
        end 
    end 

    def self.handle_next_inventory_action(action, player)
        case action
        when "b"
            return false

        when "help"
            Display.inventory_options()
            return true 
            
        when "e"
            item_idx = self.choose_item_to_equip().to_i
            item_idx -= 1 
            if (item_idx < 0 || item_idx >= player.inventory.length)
                puts "Invalid inventory option."
                press_any_key_to_continue()
                return true
            end 

            item = player.get_item_at_inventory_index(item_idx)
            equipped = player.equip_item(item)
            if (equipped)
                player.remove_item_from_inventory_at_index(item_idx)
                puts "item equipped"
            else 
                puts "unable to equip item"
            end 

            press_any_key_to_continue()
            return true

        when "u"
            item = self.choose_item_to_equip()
            
            case item
            when "w"
                player.unequip_item(:weapon_slot)

            when "s"
                player.unequip_item(:shield_slot)

            when "b"
                player.unequip_item(:body_slot)

            when "l"
                player.unequip_item(:leg_slot)

            else 
                puts "Invalid options selected."
                press_any_key_to_continue()
                return true
                
            end

            puts "item unequipped"
            return true
        
        when "c"
            item_idx = self.choose_item_to_use().to_i
            item_idx -= 1 
            if (item_idx < 0 || item_idx >= player.inventory.length)
                puts "Invalid inventory option."
                press_any_key_to_continue()
                return true
            end 

            item = player.get_item_at_inventory_index(item_idx)
            #  TODO: implement use logic
            puts "Using #{item.name}"
            press_any_key_to_continue()
            return true

        else
            return true
        end
    end 


    def self.get_next_action(prompt='> ')
        STDIN.iflush()
        puts "What would you like to do? ('help' for options)"
        print prompt
        gets.chomp 
    end

    def self.choose_item_to_use()
        puts "What item would you like to use?"
        print "> "
        gets.chomp
    end  

    def self.choose_item_to_equip()
        puts "What item would you like to equip?"
        print "> "
        gets.chomp
    end  

    def self.choose_item_to_unequip()
        puts "What item would you like to unequip?"
        puts "w - weapon"
        puts "s - shield"
        puts "b - body"
        puts "l - legs"
        print "> "
        gets.chomp
    end  
end 