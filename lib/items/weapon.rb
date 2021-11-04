class Weapon 
    attr_reader :name 
    attr_reader :power

    def initialize(name, stats)
        @name = name 
        @power = stats[:power]
    end 

    def equip(character)
        #  DO STUFF
    end 

    def to_s 
        @name 
    end 
end