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

    def self.index_in_inventory?(player, item_idx)
        return item_idx >= 0 && item_idx < player.inventory.length
    end 

    def self.display_invalid_inventory_idx 
        puts "Invalid inventory option."
        press_any_key_to_continue()
    end

    def self.equip_item(player)
        item_idx = self.get_item_selection().to_i - 1 
        if (self.index_in_inventory?(player, item_idx) == false)
            self.display_invalid_inventory_idx()
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
    end 

    def self.unequip_item(player)
        item = self.get_item_selection()
            
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
        press_any_key_to_continue()
        return true
    end 

    def self.consume_item(player)
        item_idx = self.choose_item_to_use().to_i - 1
        if (self.index_in_inventory?(player, item_idx) == false)
            self.display_invalid_inventory_idx()
            return true
        end 

        item = player.get_item_at_inventory_index(item_idx)
        if (item.type == :consumable)
            item.consume(player)
            player.remove_item_from_inventory_at_index(item_idx)
            puts "You used #{item.name}"
        else 
            puts "Unable to use selected item."
        end 

        press_any_key_to_continue()
        return true
    end 

    def self.drop_item(player)
        item_idx = self.get_item_selection().to_i - 1 
        if (self.index_in_inventory?(player, item_idx) == false)
            self.display_invalid_inventory_idx()
            return true
        end 

        item = player.get_item_at_inventory_index(item_idx)
        puts "Are you sure you want to drop this item: #{item.name}? (y/n)"
        choice = gets.chomp 

        if (choice != 'y')
            puts "Drop item canceled."
            return true
        end 

        player.remove_item_from_inventory_at_index(item_idx)
        puts "#{item.name} dropped."
        press_any_key_to_continue()
        return true
    end

    def self.show_item_detail(player)
        item_selection = self.get_item_view_selection()
        item = nil 

        case item_selection
        when "w"
            item = player.get_item_by_slot_name(:weapon_slot)

        when "s"
            item = player.get_item_by_slot_name(:shield_slot)

        when "b"
            item = player.get_item_by_slot_name(:body_slot)

        when "l"
            item = player.get_item_by_slot_name(:leg_slot)
        
        else 
            item_idx = item_selection.to_i - 1
            if (self.index_in_inventory?(player, item_idx))
                item = player.get_item_at_inventory_index(item_idx)
            else  
                item = nil
            end 
        end 
        
        if (item == nil)
            puts "Unable to view that item"
            press_any_key_to_continue()
            return true 
        end 

        system "clear"
        Display.show_item_detail(item)
        press_any_key_to_continue()
        return true
    end

    def self.handle_next_inventory_action(action, player)
        case action
        when "b"
            return false

        when "help"
            Display.inventory_options()
            return true 
            
        when "e"
            return self.equip_item(player)

        when "u"
            return self.unequip_item(player)
        
        when "c"
            return self.consume_item(player)

        when "d"
            return self.drop_item(player)

        when "v"
            return self.show_item_detail(player)

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

    def self.get_item_view_selection()
        puts "Choose item to view: "
        puts "w - equipped weapon"
        puts "s - equipped shield"
        puts "b - equipped body"
        puts "l - equipped legs"
        puts "<#> - inventory slot number"
        print "> "
        gets.chomp
    end 

    def self.choose_item_to_use()
        puts "What item would you like to use?"
        print "> "
        gets.chomp
    end  

    def self.get_item_selection()
        puts "Select inventory item: "
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