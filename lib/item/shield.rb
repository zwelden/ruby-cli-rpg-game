require 'item/item'

# Class defines all items that can be equipped in shield slots 
class Shield < Item
    attr_reader :armor

    # intialize method 
    #
    # @param [string] name - name of the shield 
    # @param [int] gold_value - in game value of shield item 
    # @param [hash] stats - stats of shield piece
    #                     - at a minimum requires [int] :armor
    def initialize(name, gold_value, stats)
        super(name, :shield, gold_value: gold_value)

        @armor = stats[:armor]
    end 
end