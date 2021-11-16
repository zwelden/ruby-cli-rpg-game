require 'item/potion'
require 'character/player'

describe Potion do 

    it "inherits from Item class" do 
        potion = Potion.new("Test Potion", 10, {health_points: 15})
        expect(potion.class.superclass ).to eq Item 
    end 

    it "has an item type of :consumable when created" do 
        potion = Potion.new("Test Potion", 10, {health_points: 15})
        expect( potion.type ).to eq :consumable 
    end 

    it "has a publicly readable health points attribute once created" do  
        health_points = 15
        potion = Potion.new("Test Potion", 10, {health_points: health_points})
        expect( potion.health_points ).to eq health_points 
    end 

    it "has a gold_value equal to instantiated gold value" do 
        gold_value = 25
        potion = Potion.new("Test Potion", gold_value, {health_points: 15})
        expect( potion.gold_value ).to eq gold_value 
    end 

    it "increases target characters health by health points value when consumed" do 
        player = Player.new("Test Player")

        health_points = 15
        potion = Potion.new("Test Potion", 10, {health_points: health_points})

        player.reduce_health(40)
        potion.consume(player)
        expect( player.health ).to eq (player.max_health - 40 + health_points)
    end 
end 