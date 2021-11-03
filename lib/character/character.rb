class Character 
    attr_reader :name 
    attr_reader :health
    attr_reader :max_health 
    attr_reader :strength 
    attr_reader :defense
    attr_reader :level
    attr_reader :inventory 
    attr_reader :gold

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
        @inventory.concat(inventory)
    end 
end
