# Parent class for all game items 
class Item 
    attr_reader :name 
    attr_reader :type
    attr_reader :gold_value

    # Initialize method 
    #
    # @param [string] name - name of item 
    # @param [symbol] type - item category 
    # @param [int] gold_value 
    def initialize(name, type, gold_value: 0)
        @name = name 
        @type = type
        @gold_value = gold_value
    end 

    # Determin if item is sellable. 
    # All items with a > zero gold value are sellable
    def can_sell? 
        return @gold_value > 0
    end 

    def to_s 
        @name 
    end 
end 