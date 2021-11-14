require 'character/character'

describe Character do 
    it "is alive on create" do
        char = Character.new("test char", 1, 1, 1, 1)
        expect(char.is_alive?).to eq true 
    end 
end 