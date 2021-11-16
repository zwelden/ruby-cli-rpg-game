require 'item/shield'

describe Shield do 

    it "inherits from Item class" do 
        shield = Shield.new("Test Shield", 10, {armor: 5})
        expect( shield.class.superclass ).to eq Item 
    end 

    it "has an item type of :shield when created" do 
        shield = Shield.new("Test Shield", 10, {armor: 5})
        expect( shield.type ).to eq :shield 
    end 

    it "has a publicly readable armor attribute once created" do  
        armor_rating = 10
        shield = Shield.new("Test Shield", 10, {armor: armor_rating})
        expect( shield.armor ).to eq armor_rating 
    end 

    it "has a gold_value equal to instantiated gold value" do 
        gold_value = 25
        shield = Shield.new("Test Shield", gold_value, {armor: 5})
        expect( shield.gold_value ).to eq gold_value 
    end 
end 