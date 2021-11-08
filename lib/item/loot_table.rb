require 'json'

class LootTable 
    TABLE_FILE_PATH = File.expand_path(File.dirname(__FILE__)) + '/tables'

    attr_reader :loot_table

    def initialize
        file_path = TABLE_FILE_PATH + '/generic_loot_table.json'
        file = File.read(file_path)
        @loot_table = JSON.parse(file, {symbolize_names: true})
    end 

    def generate_loot_roll_map
        loot_roll_arr = []
        @loot_table.each do |key, item_info|
            weight = item_info[:weight] 
            weight.times do 
                loot_roll_arr.push(key)
            end 
        end 

        loot_roll_arr 
    end 

    def get_random_item
        loot_roll_arr = generate_loot_roll_map()

        sum_weights = 0 
        @loot_table.each do |key, item_info|
            sum_weights += item_info[:weight] 
        end 

        loot_roll_idx = rand(1..sum_weights) - 1 
        loot_item_key = loot_roll_arr[loot_roll_idx]
        
        loot_item_key
    end 
end 