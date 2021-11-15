require 'character/character'
require 'item/item'
require 'item/weapon'
require 'item/armor'
require 'item/shield'

describe Character do 
    # Name Tests 
    it "character name matches given name" do
        name = "Jonny Cash"
        char = Character.new(name, 1, 1, 1, 1)
        expect(char.name).to eq name
    end

    # Health Tests
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

    it "has maximum health equal to initial health value on create" do 
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

    # Strength 
    it "starting strength matches given strength" do
        strength = 5
        char = Character.new("test char", 1, strength, 1, 1)
        expect(char.strength).to eq strength
    end

    # Defense 
    it "starting defense matches given defense" do
        defense = 4
        char = Character.new("test char", 1, 1, defense, 1)
        expect(char.defense).to eq defense
    end

    # Level 
    it "starting level matches given level" do
        level = 3
        char = Character.new("test char", 1, 1, 1, level)
        expect(char.level).to eq level
    end

    # Inventory
    it "default inventory is an empty array" do
        char = Character.new("test char", 1, 1, 1, 1)
        expect(char.inventory.class).to eq Array 
        expect(char.inventory.length).to eq 0
    end

    it "starting inventory contains passed array of items" do
        weapon_item = Weapon.new("test weapon", 5, {power: 5})
        armor_item = Armor.new("test armor", 4, {armor: 3, armor_type: "body"})
        char = Character.new("test char", 1, 1, 1, 1, inventory: [weapon_item, armor_item])
        expect(char.inventory.length).to eq 2
    end

    it "an item can be added to inventory" do 
        char = Character.new("test char", 1, 1, 1, 1)
        weapon_item = Weapon.new("test weapon", 5, {power: 5})
        char.add_item_to_inventory(weapon_item)
        expect(char.inventory.length).to eq 1
    end 

    it "an item can be retfrieved from an inventory by index value" do 
        weapon_item = Weapon.new("test weapon", 5, {power: 5})
        armor_item = Armor.new("test armor", 4, {armor: 3, armor_type: "body"})
        char = Character.new("test char", 1, 1, 1, 1, inventory: [weapon_item, armor_item])
        expect(char.get_item_at_inventory_index(0)).to eq weapon_item
        expect(char.get_item_at_inventory_index(1)).to eq armor_item
    end

    it "multiple items can be added to inventory at once" do 
        char = Character.new("test char", 1, 1, 1, 1)
        weapon_item = Weapon.new("test weapon", 5, {power: 5})
        armor_item = Armor.new("test armor", 4, {armor: 3, armor_type: "body"})
        char.add_inventory([weapon_item, armor_item])
        expect(char.inventory.length).to eq 2
    end

    it "items can be removed from inventory" do 
        weapon_item = Weapon.new("test weapon", 5, {power: 5})
        char = Character.new("test char", 1, 1, 1, 1, inventory: [weapon_item])
        char.remove_item_from_inventory_at_index(0)
        expect(char.inventory.length).to eq 0
    end

    it "attempting to retrieve an item at an invalid index returns nil" do 
        weapon_item = Weapon.new("test weapon", 5, {power: 5})
        char = Character.new("test char", 1, 1, 1, 1, inventory: [weapon_item])
        expect(char.get_item_at_inventory_index(1)).to eq nil
    end

    it "an item can be equipped" do 
        weapon_item = Weapon.new("test weapon", 5, {power: 5})
        body_armor_item = Armor.new("test body armor", 4, {armor: 3, armor_type: "body"})
        leg_armor_item = Armor.new("test leg armor", 4, {armor: 2, armor_type: "legs"})
        shield_item = Shield.new("test weapon", 5, {armor: 1})
        char = Character.new("test char", 1, 1, 1, 1)
        expect( char.equip_item(weapon_item) ).to eq true
        expect( char.equip_item(body_armor_item) ).to eq true
        expect( char.equip_item(leg_armor_item) ).to eq true
        expect( char.equip_item(shield_item) ).to eq true
    end 

    it "attempting to equip a non equipable item returns false" do
        item = Item.new("non-equipable item", :random_type)
        char = Character.new("test char", 1, 1, 1, 1)
        expect( char.equip_item(item) ).to eq false
    end 

    it "an equipped item can be retrieved by slot name" do 
        weapon_item = Weapon.new("test weapon", 5, {power: 5})
        body_armor_item = Armor.new("test body armor", 4, {armor: 3, armor_type: "body"})
        leg_armor_item = Armor.new("test leg armor", 4, {armor: 2, armor_type: "legs"})
        shield_item = Shield.new("test weapon", 5, {armor: 1})
        char = Character.new("test char", 1, 1, 1, 1)
        char.equip_item(weapon_item)
        char.equip_item(body_armor_item)
        char.equip_item(leg_armor_item)
        char.equip_item(shield_item)
        expect(char.get_item_by_slot_name(:weapon_slot)).to eq weapon_item
        expect(char.get_item_by_slot_name(:body_slot)).to eq body_armor_item
        expect(char.get_item_by_slot_name(:leg_slot)).to eq leg_armor_item
        expect(char.get_item_by_slot_name(:shield_slot)).to eq shield_item
    end

    it "an item can be equipped from inventory" do 
        weapon_item = Weapon.new("test weapon", 5, {power: 5})
        body_armor_item = Armor.new("test body armor", 4, {armor: 3, armor_type: "body"})
        leg_armor_item = Armor.new("test leg armor", 4, {armor: 2, armor_type: "legs"})
        shield_item = Shield.new("test weapon", 5, {armor: 1})
        char = Character.new("test char", 1, 1, 1, 1, inventory: [weapon_item, body_armor_item, leg_armor_item, shield_item])
        char.equip_item_from_inventory_by_index(0)
        char.equip_item_from_inventory_by_index(0)
        char.equip_item_from_inventory_by_index(0)
        char.equip_item_from_inventory_by_index(0)
        expect(char.inventory.length).to eq 0
        expect(char.get_item_by_slot_name(:weapon_slot)).to eq weapon_item
        expect(char.get_item_by_slot_name(:body_slot)).to eq body_armor_item
        expect(char.get_item_by_slot_name(:leg_slot)).to eq leg_armor_item
        expect(char.get_item_by_slot_name(:shield_slot)).to eq shield_item
    end 

    it "unequipping an item returns it to inventory" do 
        weapon_item = Weapon.new("test weapon", 5, {power: 5})
        char = Character.new("test char", 1, 1, 1, 1)
        char.equip_item(weapon_item)
        char.unequip_item(:weapon_slot)
        expect(char.inventory.length).to eq 1
    end 

    it "equipping an item into an already equipped slot returns previously equipped item to inventory" do 
        weapon_item = Weapon.new("test weapon", 5, {power: 5})
        second_weapon_item = Weapon.new("test weapon 2", 3, {power: 1})
        char = Character.new("test char", 1, 1, 1, 1)
        char.equip_item(weapon_item)
        char.equip_item(second_weapon_item)
        expect(char.inventory.length).to eq 1
        expect(char.get_item_at_inventory_index(0)).to eq weapon_item
    end 

    it "attempting to retrieve an item from an unequipped slot returns nil" do 
        char = Character.new("test char", 1, 1, 1, 1)
        expect(char.get_item_by_slot_name(:shield_slot)).to eq nil
    end

    it "attempting to retrieve an invalid slot returns nil" do 
        char = Character.new("test char", 1, 1, 1, 1)
        expect(char.get_item_by_slot_name(:not_a_real_slot)).to eq nil
    end 

    it "calculates stats based on eqipped items" do 
        weapon_power = 7
        weapon_item = Weapon.new("test weapon", 5, {power: weapon_power})
        char = Character.new("test char", 1, 1, 1, 1)
        char.equip_item(weapon_item)
        expect(char.get_equipped_stat_value(:power)).to eq weapon_power
    end 

    it "get_attack_power method returns equipped attack power" do 
        weapon_power = 7
        weapon_item = Weapon.new("test weapon", 5, {power: weapon_power})
        char = Character.new("test char", 1, 1, 1, 1)
        char.equip_item(weapon_item)
        expect(char.get_attack_power()).to eq weapon_power
    end 

    it "get_armor method returns correct armor value" do 
        body_armor_item = Armor.new("test body armor", 4, {armor: 3, armor_type: "body"})
        leg_armor_item = Armor.new("test leg armor", 4, {armor: 2, armor_type: "legs"})
        shield_item = Shield.new("test weapon", 5, {armor: 1})
        char = Character.new("test char", 1, 1, 1, 1)
        char.equip_item(body_armor_item)
        char.equip_item(leg_armor_item)
        char.equip_item(shield_item)
        expect(char.get_armor()).to eq 6 
    end

    # Gold Tests
    it "has a default gold value of 0 if not amount specified on creation" do
        char = Character.new("test char", 1, 1, 1, 1)
        expect(char.gold).to eq 0 
    end 

    it "has a starting gold value equal to amount specified at creation if given" do
        starting_gold = 10
        char = Character.new("test char", 1, 1, 1, 1, gold: starting_gold)
        expect(char.gold).to eq starting_gold
    end

    it "increases gold holding by amount added" do 
        starting_gold = 10
        char = Character.new("test char", 1, 1, 1, 1, gold: starting_gold)
        char.add_gold(10)
        expect(char.gold).to eq (starting_gold + 10)
    end

    it "reduces gold holding by amount subtracted" do
        starting_gold = 10
        char = Character.new("test char", 1, 1, 1, 1, gold: starting_gold)
        char.reduce_gold(5)
        expect(char.gold).to eq (starting_gold - 5)
    end

    it "canont reduce gold holding below 0" do
        starting_gold = 10
        char = Character.new("test char", 1, 1, 1, 1, gold: starting_gold)
        char.reduce_gold(20)
        expect(char.gold).to eq 0
    end

    # Experience 
    it "can calculate experience generated for a kill" do 
        char1 = Character.new("test char", 1, 1, 1, 1)
        char2 = Character.new("test char", 1, 1, 1, 3)
        char3 = Character.new("test char", 1, 1, 1, 10)
        expect(char1.calculate_reward_experience()).to eq 25
        expect(char2.calculate_reward_experience()).to eq 35
        expect(char3.calculate_reward_experience()).to eq 70
    end 

end 