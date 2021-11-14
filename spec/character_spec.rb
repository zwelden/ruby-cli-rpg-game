require 'character/character'

describe Character do 
    it "is alive on create when starting health > 0" do
        starting_health = 1
        char = Character.new("test char", starting_health, 1, 1, 1)
        expect(char.is_alive?).to eq true 
    end 

    it "lowers health by x when reduced by x" do
        starting_health = 10
        char = Character.new("test char", starting_health, 1, 1, 1)
        char.reduce_health(4)
        expect(char.health).to eq 6 
    end 

    it "cannot have health reduced below 0" do 
        starting_health = 10
        char = Character.new("test char", starting_health, 1, 1, 1)
        char.reduce_health(20)
        expect(char.health).to eq 0
    end 

    it "is not alive when health reduced to zero" do
        starting_health = 10
        char = Character.new("test char", starting_health, 1, 1, 1)
        char.reduce_health(10)
        expect(char.is_alive?).to eq false 
    end 

    it "has maximum health equal to intial health value on create" do 
        starting_health = 10
        char = Character.new("test char", starting_health, 1, 1, 1)
        expect(char.max_health).to eq starting_health 
    end 

    it "cannot increase health above max health value" do
        starting_health = 10
        char = Character.new("test char", starting_health, 1, 1, 1)
        char.reduce_health(5)
        char.increase_health(20)
        expect(char.health).to eq starting_health 
    end 

    it "raises health by x when increased by x" do
        starting_health = 10
        char = Character.new("test char", starting_health, 1, 1, 1)
        char.reduce_health(9)
        char.increase_health(5)
        expect(char.health).to eq 6 
    end 
end 