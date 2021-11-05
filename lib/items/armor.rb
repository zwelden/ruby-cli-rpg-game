require 'items/item'

class Armor < Item
    attr_reader :armor 

    def initialize(name, gold_value, stats)
        super(name, wearable: true, gold_value: gold_value)

        @armor = stats[:armor]
    end 
end