class Shield 
    attr_reader :name 
    attr_reader :defense

    def initialize(name, stats)
        @name = name  
        @defense = stats[:defense]
    end 

    def equip(character) 
        # DO STUFF 
    end

    def to_s 
        @name 
    end 
end