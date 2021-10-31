class Monster 
    attr_reader :name 
    attr_reader :health 
    attr_reader :strength
    attr_reader :defense

    def initialize(name, health, strength, defense)
        @name = name 
        @health = health 
        @strength = strength 
        @defense = defense
    end 

    def reduce_health(amount)
        @health -= amount 
        if (@health < 0)
            @health = 0 
            :dead 
        else 
            :alive 
        end
    end 

    def is_alive? 
        return @health > 0
    end 
end
