class Armor 
    attr_reader :name 
    attr_reader :defense 

    def initialize(name, stats)
        @name = name 
        @defense = stats[:defense]
    end 

    def wear(character)
        # do stuff 
    end 

    def to_s 
        @name 
    end 
end