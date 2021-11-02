require "character/character"

class Enemy < Character
    def initialize(name, health, strength, defense, level)
        super(name, health, strength, defense, level)
    end 
end
