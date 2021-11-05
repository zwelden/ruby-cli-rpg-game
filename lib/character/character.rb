class Character 
    attr_reader :name 
    attr_reader :health
    attr_reader :max_health 
    attr_reader :strength 
    attr_reader :defense
    attr_reader :level
    attr_reader :inventory 
    attr_reader :gold
    attr_reader :equipped_item
    attr_reader :worn_item

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

    def add_inventory(inventory)
        if (inventory.length > 0)
            @inventory.concat(inventory)
        end
    end 

    def equip_item(item)
        if item.respond_to?(:equipable) && item.equipable
            currently_equipped_item = @equipped_item
            @equipped_item = item 
            
            if currently_equipped_item != nil 
                @inventory.push(currently_equipped_item)
            end 
        end 
    end

    def unequip_item 
        item = @equipped_item
        if (item.respond_to?(:equippable))
            @inventory.push(item)
            @equipped_item = nil
        end 
    end

    def wear_item(item)
        if item.respond_to?(:wearable) && item.wearable
            currently_worn_item = @worn_item 
            @worn_item = item 

            if currently_worn_item != nil 
                @inventory.push(currently_worn_item)
            end 
        end 
    end 

    def remove_worn_item 
        item = @worn_item
        if (item.respond_to?(:wearable))
            @inventory.push(item)
            @worn_item = nil
        end 
    end 

    def get_attack_power 
        attack_power = 0
        if (@equipped_item != nil && @equipped_item.respond_to?(:power))
            attack_power += @equipped_item.power
        end 

        if (@worn_item && @worn_item.respond_to?(:power))
            attack_power += @worn_item.power
        end 

        attack_power 
    end 

    def get_armor 
        armor = 0 
        if (@equipped_item && @equipped_item.respond_to?(:armor))
            armor += @equipped_item.armor
        end 

        if (@worn_item && @worn_item.respond_to?(:armor))
            armor += @worn_item.armor
        end 

        armor 
    end

end
