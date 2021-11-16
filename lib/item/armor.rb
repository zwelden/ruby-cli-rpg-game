require 'item/item'

# Class defines all items that can be equipped in armor slots 
class Armor < Item
    attr_reader :armor 
    attr_reader :armor_type

    # intialize method 
    #
    # @param [string] name - name of the armor 
    # @param [int] gold_value - in game value of armor item 
    # @param [hash] stats - stats of armor piece
    #                     - at a minimum requires [int] :armor and [string] :armor_type keys
    def initialize(name, gold_value, stats)
        super(name, :armor, gold_value: gold_value)

        @armor = stats[:armor]
        @armor_type = stats[:armor_type]
    end 
end