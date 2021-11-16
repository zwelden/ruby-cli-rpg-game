require 'item/item'

# Class defines all items that can be consumed as a potion
class Potion < Item
    attr_reader :health_points 

    # intialize method 
    #
    # @param [string] name - name of the potion 
    # @param [int] gold_value - in game value of potion item 
    # @param [hash] stats - stats of potion piece
    #                     - at a minimum requires [int] :health_points
    def initialize(name, gold_value, stats)
        super(name, :consumable, gold_value: gold_value)
        
        @health_points = stats[:health_points]
    end 

    # Increases target character's health by items health point value 
    def consume(character) 
        return if (character.respond_to?(:increase_health) == false)
        
        character.increase_health(@health_points)
    end 
end
