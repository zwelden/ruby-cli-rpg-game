require 'item/armor'

describe Armor do 

    it "inherits from Item class" do 
        armor = Armor.new("Test Armor", 10, {armor: 5, armor_type: "body"})
        expect( armor.class.superclass ).to eq Item 
    end 

    it "has an item type of :armor when created" do 
        armor = Armor.new("Test Armor", 10, {armor: 5, armor_type: "body"})
        expect( armor.type ).to eq :armor 
    end 

    it "has a publicly readable armor attribute once created" do  
        armor_rating = 10
        armor = Armor.new("Test Armor", 10, {armor: armor_rating, armor_type: "body"})
        expect( armor.armor ).to eq armor_rating 
    end 

    it "has a publicaly reader armor type attribute once created" do 
        armor_type = "body"
        armor = Armor.new("Test Armor", 10, {armor: 5, armor_type: armor_type})
        expect( armor.armor_type ).to eq armor_type 
    end 

    it "has a gold_value equal to instantiated gold value" do 
        gold_value = 25
        armor = Armor.new("Test Armor", gold_value, {armor: 5, armor_type: "legs"})
        expect( armor.gold_value ).to eq gold_value 
    end 
end 