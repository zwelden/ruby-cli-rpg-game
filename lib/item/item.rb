class Item 
    attr_reader :name 
    attr_reader :type
    attr_reader :gold_value

    def initialize(name, type, gold_value: 0)
        @name = name 
        @type = type
        @gold_value = gold_value
    end 

    def can_sell? 
        return @gold_value > 0
    end 

    def sell_value
        @gold_value 
    end 

    def buy_value 
        @gold_value * 2 
    end 

    def to_s 
        @name 
    end 
end 