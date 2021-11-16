require 'item/item'

# Class defines all items that can be equipped in weapon slots
class Weapon < Item
    attr_reader :power

    # intialize method 
    #
    # @param [string] name - name of the weapon 
    # @param [int] gold_value - in game value of weapon item 
    # @param [hash] stats - stats of weapon piece
    #                     - at a minimum requires [int] :power 
    def initialize(name, gold_value, stats)
        super(name, :weapon, gold_value: gold_value)

        @power = stats[:power]
    end 
end