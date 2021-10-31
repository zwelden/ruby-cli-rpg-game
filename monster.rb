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
end
