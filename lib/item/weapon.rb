require 'item/item'

class Weapon < Item
    attr_reader :power

    def initialize(name, gold_value, stats)
        super(name, :weapon, gold_value: gold_value)

        @power = stats[:power]
    end 
end