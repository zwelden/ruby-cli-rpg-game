class Item 
    attr_reader :name 
    attr_reader :equipable 
    attr_reader :wearable 
    attr_reader :consumable 
    attr_reader :gold_value

    def initialize(name, gold_value: 0, equipable: false, wearable: false, consumable: false)
        @name = name 
        @equipable = equipable 
        @wearable = wearable 
        @consumable = consumable
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