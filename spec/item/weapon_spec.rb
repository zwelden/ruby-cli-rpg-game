require 'item/weapon'

describe Weapon do 

    it "inherits from Item class" do 
        weapon = Weapon.new("Test Weapon", 10, {power: 5})
        expect(weapon.class.superclass ).to eq Item 
    end 

    it "has an item type of :weapon when created" do 
        weapon = Weapon.new("Test Weapon", 10, {power: 5})
        expect( weapon.type ).to eq :weapon 
    end 

    it "has a publicly readable power attribute once created" do  
        power_rating = 10
        weapon = Weapon.new("Test Weapon", 10, {power: power_rating})
        expect( weapon.power ).to eq power_rating 
    end 

    it "has a gold_value equal to instantiated gold value" do 
        gold_value = 25
        weapon = Weapon.new("Test Weapon", gold_value, {power: 5})
        expect( weapon.gold_value ).to eq gold_value 
    end 
end 