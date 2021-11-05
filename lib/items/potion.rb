require 'items/item'

class Potion < Item
    attr_reader :health_points 

    def initialize(name, gold_value, stats)
        super(name, consumable: true, gold_value: gold_value)
        
        @health_points = stats[:health_points]
    end 

    def consume(character) 
        # DO STUFF 
    end 
end
