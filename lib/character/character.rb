# Parent class for all characters that exist in the game, 
# such as Enemy or Player class. 
class Character 
    attr_reader :name 
    attr_reader :health
    attr_reader :max_health 
    attr_reader :strength 
    attr_reader :defense
    attr_reader :level
    attr_reader :inventory 
    attr_reader :gold
    attr_reader :weapon_slot
    attr_reader :shield_slot
    attr_reader :body_slot
    attr_reader :leg_slot

    # Initialize an character
    # 
    # @param [string] name - name of the character
    # @param [int] health - starting healh/max health value 
    # @param [int] strength - starting strength value 
    # @param [int] defense - starting defense value 
    # @param [int] level - starting level value 
    # @param [array[<Item>]] - starting array of inventory items
    # @param [int] gold - starting gold value 
    def initialize (name, health, strength, defense, level, inventory: [], gold: 0)
        @name = name
        @health = health 
        @max_health = health
        @strength = strength 
        @defense = defense
        @level = level 
        @inventory = inventory 
        @gold = gold
    end 

    # Reduce charaater's health by a given amount 
    # cannot be reduced below 0
    # 
    # @param [int] amount - reduction amount 
    def reduce_health(amount)
        @health -= amount 
        if (@health < 0)
            @health = 0 
        end
    end 

    # Increase character's health by a given amount 
    # cannot be increased beyond @max_health value
    # 
    # @param [int] amount - increase amount 
    def increase_health(amount)
        @health += amount 
        if (@health > @max_health)
            @health = @max_health
        end 
    end 

    # Check if character is still alive 
    def is_alive? 
        return @health > 0
    end 

    # Add gold to a character 
    #
    # @param [int] amount 
    def add_gold(amount)
        @gold += amount 
    end 

    # Remove gold from a character 
    # cannot be reduced below 0
    #
    # @param [int] amount 
    def reduce_gold(amount)
        @gold -= amount 

        if (@gold <= 0)
            @gold = 0 
        end 
    end 

    # Add an array of Item objects to a character's inventory. 
    # (For adding a single Item use `add_item_to_inventory(item)` below)
    #
    # @param [array[<Item>]] new_inventory 
    def add_inventory(new_inventory)
        if (new_inventory.length > 0)
            @inventory.concat(new_inventory)
        end
    end 

    # Add a single item to a character's inventory
    #
    # @param [<Item>] item
    def add_item_to_inventory(item)
        return if item.nil?
        
        @inventory.push(item)
    end 

    # Check if desired inventory index exists 
    #
    # @param [int] index
    def index_in_inventory?(index)
        return (@inventory.length > 0 && index >= 0 && index < @inventory.length)
    end

    # Return the inventory item found at the given index 
    #
    # @param [int] index
    def get_item_at_inventory_index(index)
        if (index >= 0 && index < @inventory.length)
            return @inventory[index]
        end 
        
        nil 
    end 

    # Return the item present in a given equipped equipment slot 
    #
    # @param [symbol] slot
    def get_item_by_slot_name(slot)
        case slot
        when :shield_slot
            @shield_slot

        when :weapon_slot
            @weapon_slot

        when :body_slot
            @body_slot

        when :leg_slot
            @leg_slot

        else 
            nil
        end 
    end 

    # Remove an item from character's inventory at a given index 
    #
    # @param [int] index
    def remove_item_from_inventory_at_index(index)
        @inventory.delete_at(index)
    end 

    # Equip a given item
    # Equipped slot determined by the Item's type and aromor_type (if present) variables
    # If an item is already present in a slot it will be returned to the character's inventory 
    #
    # @param [<Item>] item
    def equip_item(item)
        current_item = nil
        equipped = false

        case item.type
        when :shield
            current_item = @shield_slot
            @shield_slot = item 
            equipped = true

        when :weapon
            current_item = @weapon_slot
            @weapon_slot = item 
            equipped = true

        when :armor
            armor_type = item.armor_type

            case armor_type
            when "body"
                current_item = @body_slot
                @body_slot = item 
                equipped = true

            when "legs"
                current_item = @leg_slot
                @leg_slot = item 
                equipped = true
  
            end 
        end

        if current_item != nil 
            @inventory.push(current_item)
        end 

        equipped
    end

    # equipe an item from inventory 
    # handles getting, equipping, and removing items from inventory 
    #
    # @param [int] index
    def equip_item_from_inventory_by_index(index) 
        item = get_item_at_inventory_index(index)
        return if item.nil? 

        equipped = equip_item(item)
        return if equipped == false 

        remove_item_from_inventory_at_index(index)
    end 

    # Remove an equipped item by slot name and return it to the character's inventory 
    #
    # @param [symbol] slot
    def unequip_item(slot)
        case slot
        when :shield_slot
            item = @shield_slot
            @shield_slot = nil

        when :weapon_slot
            item = @weapon_slot
            @weapon_slot = nil

        when :body_slot
            item = @body_slot
            @body_slot = nil

        when :leg_slot
            item = @leg_slot
            @leg_slot = nil
            
        end

        if (item != nil)
            @inventory.push(item)
        end
    end

    # Calculate the experiene generated by killing character
    #
    # @return [int]
    def calculate_reward_experience 
        return 20 + (5 * @level)
    end 

    # Calculate the value of a desired stat (ex: `:power`) generated by all equipped items 
    #
    # @param [symbol] stat 
    # @return [int]
    def get_equipped_stat_value(stat)
        items = [@shield_slot, @weapon_slot, @body_slot, @leg_slot]
        stat_value = 0

        items.each do |item|
            if (item != nil && item.respond_to?(stat))
                stat_value += item.__send__(stat)
            end 
        end

        stat_value 
    end 

    # wrapper method to get attack power value for equipped items
    def get_attack_power 
        get_equipped_stat_value(:power)
    end 

    # wrapper method to get armor value for equipped items
    def get_armor 
        get_equipped_stat_value(:armor)
    end

end
