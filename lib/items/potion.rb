class Potion 
    attr_reader :name 
    attr_reader :health_points 

    def initialize(name, stats)
        @name = name 
        @health_points = stats[:health_points]
    end 

    def consume(character) 
        # DO STUFF 
    end 

    def to_s 
        @name 
    end 
end
