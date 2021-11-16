require 'item/item'

describe Item do 
    
    it "has a publicly readable name attribute once created" do 
        item_name = "Test Item"
        item = Item.new(item_name, :test)
        expect( item.name ).to eq item_name
    end 

    it "has a publicly readable type attribue once created" do 
        item_type = :test_type 
        item = Item.new("Test Item", item_type)
        expect( item.type ).to eq item_type 
    end 

    it "has a default gold value of 0 is none is specified" do 
        item = Item.new("Test Item", :test_type)
        expect( item.gold_value ).to eq 0 
    end 

    it "has a gold value that can be set by a named parameter on create" do 
        gold_value = 100 
        item = Item.new("Test Item", :test_type, gold_value: gold_value)
        expect( item.gold_value ).to eq gold_value 
    end 

    it "items with the default gold value are not sellable" do 
        item = Item.new("Test Item", :test_item)
        expect( item.can_sell? ).to eq false 
    end 

    it "items with > 0 gold value are sellable" do 
        item = Item.new("Test Item", :test_item, gold_value: 10)
        expect( item.can_sell? ).to eq true 
    end 
end