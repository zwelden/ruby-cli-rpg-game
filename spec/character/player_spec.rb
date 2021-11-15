require 'character/player'

describe Player do 

    it "inherits from Character class" do
        player = Player.new("test player")
        expect(player.class.superclass).to eq Character
        expect( player.is_alive? ).to eq true
        expect( player.respond_to?(:name) ).to eq true
        expect( player.respond_to?(:health) ).to eq true
        expect( player.respond_to?(:strength) ).to eq true
        expect( player.respond_to?(:defense) ).to eq true
        expect( player.respond_to?(:level) ).to eq true
        expect( player.respond_to?(:inventory) ).to eq true
        expect( player.respond_to?(:gold) ).to eq true
        expect( player.respond_to?(:add_gold) ).to eq true
        expect( player.respond_to?(:reduce_gold) ).to eq true
        expect( player.respond_to?(:reduce_health) ).to eq true
        expect( player.respond_to?(:increase_health) ).to eq true
        expect( player.respond_to?(:equip_item) ).to eq true
        expect( player.respond_to?(:unequip_item) ).to eq true
        expect( player.respond_to?(:add_item_to_inventory) ).to eq true
        expect( player.respond_to?(:get_item_at_inventory_index) ).to eq true
        expect( player.respond_to?(:add_inventory) ).to eq true
        expect( player.respond_to?(:remove_item_from_inventory_at_index) ).to eq true
        expect( player.respond_to?(:get_item_by_slot_name) ).to eq true
        expect( player.respond_to?(:equip_item_from_inventory_by_index) ).to eq true
        expect( player.respond_to?(:get_equipped_stat_value) ).to eq true
        expect( player.respond_to?(:get_attack_power) ).to eq true
        expect( player.respond_to?(:get_armor) ).to eq true
        expect( player.respond_to?(:calculate_reward_experience) ).to eq true
    end 

    it "initializes with 50 health, 6 strength, 3 defense, and level 1" do 
        player = Player.new("test player")
        expect( player.health ).to eq 50
        expect( player.strength ).to eq 6
        expect( player.defense ).to eq 3
        expect( player.level ).to eq 1
    end 

    it "intializes with and empty inventory" do 
        player = Player.new("test player")
        expect( player.inventory.length ).to eq 0
    end

    it "initializes with 3 equipped items: weapon, body armor, and leg armor" do 
        player = Player.new("test player")
        expect( player.get_item_by_slot_name(:weapon_slot).name ).to eq "Rusty Dagger"
        expect( player.get_item_by_slot_name(:body_slot).name ).to eq "Old Cloth Tunic"
        expect( player.get_item_by_slot_name(:leg_slot).name ).to eq "Old Cloth Pants"
    end 

    it "can generate a new player object with prompt for name" do
        allow_any_instance_of(Object).to receive(:gets).and_return("George Washington")
        player = nil
        expect { player = Player.generate_new_player() }.to output.to_stdout
        expect(player.name).to eq 'George Washington'
    end

    it "sleeping displays an animation to stdio and increases health by half max health" do 
        player = Player.new("test player")
        max_health = player.health
        player.reduce_health( (max_health - 1) )
        player.sleep(show_animation: false)
        expect(player.health).to eq (max_health - (max_health / 2) + 1)
    end

end