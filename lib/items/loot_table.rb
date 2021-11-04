class LootTable 
    LOOT_TABLE = [
        {
            name: "Dagger",
            weight: 10,
            type: :weapon,
            power: 5
        },
        {
            name: "Sword",
            weight: 10,
            type: :weapon,
            power: 10
        },
        {
            name: "Mace",
            weight: 10,
            type: :weapon,
            power: 8
        },
        {
            name: "Staff",
            weight: 10,
            type: :weapon,
            power: 6
        },
        {
            name: "Buckler",
            weight: 10,
            type: :sheld,
            defense: 3
        },
        {
            name: "Wood Shield",
            weight: 10,
            type: :sheld,
            defense: 5
        },
        {
            name: "Steel Shield",
            weight: 10,
            type: :sheld,
            defense: 10
        },
        {
            name: "Minor Healing Potion",
            weight: 10,
            type: :potion,
            health_points: 10
        },
        {
            name: "Major Healing Potion",
            weight: 5,
            type: :potion,
            health_points: 25
        },
        {
            name: "Cloth Tunic",
            weight: 10,
            type: :armor,
            defense: 2
        },
        {
            name: "Leather Tunic",
            weight: 10,
            type: :armor,
            defense: 5
        },
        {
            name: "Chain Mail",
            weight: 10,
            type: :armor,
            defense: 10
        },
        {
            name: "Plate Mail",
            weight: 10,
            type: :armor,
            defense: 15
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