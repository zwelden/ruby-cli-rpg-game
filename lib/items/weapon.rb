require 'items/item'

class Weapon < Item
    attr_reader :power

    def initialize(name, gold_value, stats)
        super(name, equipable: true, gold_value: 0)

        @power = stats[:power]
    end 
end