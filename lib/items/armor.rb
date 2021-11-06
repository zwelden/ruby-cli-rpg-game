require 'items/item'

class Armor < Item
    attr_reader :armor 
    attr_reader :armor_type

    def initialize(name, gold_value, stats)
        super(name, :armor, gold_value: gold_value)

        @armor = stats[:armor]
        @armor_type = stats[:armor_type]
    end 
end