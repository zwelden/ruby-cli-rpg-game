require 'items/item'

class Shield < Item
    attr_reader :armor

    def initialize(name, gold_value, stats)
        super(name, :shield, gold_value: gold_value)

        @armor = stats[:armor]
    end 
end