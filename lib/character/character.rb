class Character 
    attr_reader :name 
    attr_reader :health
    attr_reader :max_health 
    attr_reader :strength 
    attr_reader :defense
    attr_reader :level

    def initialize (name, health, strength, defense, level)
        @name = name
        @health = health 
        @max_health = health
        @strength = strength 
        @defense = defense
        @level = level 
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

end
