require 'game_log'
class LootTable 
    LOOT_TABLE = [
        {
            name: "Dagger",
            weight: 10,
            type: :weapon,
            power: 5,
            gold_value: 5
        },
        {
            name: "Sword",
            weight: 10,
            type: :weapon,
            power: 10,
            gold_value: 10
        },
        {
            name: "Mace",
            weight: 10,
            type: :weapon,
            power: 8,
            gold_value: 8
        },
        {
            name: "Staff",
            weight: 10,
            type: :weapon,
            power: 6,
            gold_value: 7
        },
        {
            name: "Buckler",
            weight: 10,
            type: :shield,
            armor: 3,
            gold_value: 5
        },
        {
            name: "Wood Shield",
            weight: 10,
            type: :shield,
            armor: 5,
            gold_value: 10
        },
        {
            name: "Steel Shield",
            weight: 10,
            type: :shield,
            armor: 10,
            gold_value: 15
        },
        {
            name: "Minor Healing Potion",
            weight: 10,
            type: :potion,
            health_points: 10,
            gold_value: 10
        },
        {
            name: "Major Healing Potion",
            weight: 5,
            type: :potion,
            health_points: 25,
            gold_value: 20
        },
        {
            name: "Cloth Tunic",
            weight: 10,
            type: :armor,
            armor: 2,
            gold_value: 5
        },
        {
            name: "Leather Tunic",
            weight: 10,
            type: :armor,
            armor: 5,
            sell_gold: 10
        },
        {
            name: "Chain Mail",
            weight: 10,
            type: :armor,
            armor: 10,
            sell_gold: 15
        },
        {
            name: "Plate Mail",
            weight: 10,
            type: :armor,
            armor: 15,
            sell_gold: 20
        }
    ]

    def self.generate_loot_roll_map
        loot_roll_arr = []
        LOOT_TABLE.each_with_index do |item, item_idx|
            weight = item[:weight] 
            weight.times do 
                loot_roll_arr.push(item_idx)
            end 
        end 

        loot_roll_arr 
    end 

    def self.get_random_item
        loot_roll_arr = self.generate_loot_roll_map()

        sum_weights = 0 
        LOOT_TABLE.each do |item|
            sum_weights += item[:weight] 
        end 

        loot_roll_idx = rand(1..sum_weights) - 1 
        loot_item_idx = loot_roll_arr[loot_roll_idx]
        
        LOOT_TABLE[loot_item_idx] 
    end 
end 