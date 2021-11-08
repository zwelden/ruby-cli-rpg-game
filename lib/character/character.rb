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

    def reduce_health(amount)
        @health -= amount 
        if (@health < 0)
            @health = 0 
        end
    end 

    def increase_health(amount)
        @health += amount 
        if (@health > @max_health)
            @health = @max_health
        end 
    end 

    def is_alive? 
        return @health > 0
    end 

    def add_gold(amount)
        @gold += amount 
    end 

    def add_inventory(new_inventory)
        if (new_inventory.length > 0)
            @inventory.concat(new_inventory)
        end
    end 

    def get_item_at_inventory_index(index)
        if (index >= 0 && index < @inventory.length)
            return @inventory[index]
        end 
        
        nil 
    end 

    def remove_item_from_inventory_at_index(index)
        @inventory.delete_at(index)
    end 

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
            when :body 
                current_item = @body_slot
                @body_slot = item 
                equipped = true

            when :legs
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

    def get_attack_power 
        get_equipped_stat_value(:power)
    end 

    def get_armor 
        get_equipped_stat_value(:armor)
    end

end
