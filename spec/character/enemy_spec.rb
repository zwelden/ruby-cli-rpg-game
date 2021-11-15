require 'character/enemy'

describe Enemy do 

    it "inherits from Character class" do
        enemy = Enemy.new("test enemy", 1, 1, 1, 1)
        expect(enemy.class.superclass).to eq Character
        expect( enemy.is_alive? ).to eq true
        expect( enemy.respond_to?(:name) ).to eq true
        expect( enemy.respond_to?(:health) ).to eq true
        expect( enemy.respond_to?(:strength) ).to eq true
        expect( enemy.respond_to?(:defense) ).to eq true
        expect( enemy.respond_to?(:level) ).to eq true
        expect( enemy.respond_to?(:inventory) ).to eq true
        expect( enemy.respond_to?(:gold) ).to eq true
        expect( enemy.respond_to?(:add_gold) ).to eq true
        expect( enemy.respond_to?(:reduce_gold) ).to eq true
        expect( enemy.respond_to?(:reduce_health) ).to eq true
        expect( enemy.respond_to?(:increase_health) ).to eq true
        expect( enemy.respond_to?(:equip_item) ).to eq true
        expect( enemy.respond_to?(:unequip_item) ).to eq true
        expect( enemy.respond_to?(:add_item_to_inventory) ).to eq true
        expect( enemy.respond_to?(:get_item_at_inventory_index) ).to eq true
        expect( enemy.respond_to?(:add_inventory) ).to eq true
        expect( enemy.respond_to?(:remove_item_from_inventory_at_index) ).to eq true
        expect( enemy.respond_to?(:get_item_by_slot_name) ).to eq true
        expect( enemy.respond_to?(:equip_item_from_inventory_by_index) ).to eq true
        expect( enemy.respond_to?(:get_equipped_stat_value) ).to eq true
        expect( enemy.respond_to?(:get_attack_power) ).to eq true
        expect( enemy.respond_to?(:get_armor) ).to eq true
        expect( enemy.respond_to?(:calculate_reward_experience) ).to eq true
    end 

end