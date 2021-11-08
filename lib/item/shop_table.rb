require 'json'

class ShopTable 
    TABLE_FILE_PATH = File.expand_path(File.dirname(__FILE__)) + '/tables'

    attr_reader :item_weight_table
    attr_reader :item_roll_map

    def initialize(type, level)
        file_path = TABLE_FILE_PATH + "/#{type}_level_#{level}_shop_table.json"
        file = File.read(file_path)
        @item_weight_table = JSON.parse(file, {symbolize_names: true})
        @item_roll_map = generate_item_roll_map()
    end 

    def generate_item_roll_map
        item_roll_arr = []
        @item_weight_table.each do |key, item_info|
            weight = item_info[:weight] 
            weight.times do 
                item_roll_arr.push(key)
            end 
        end 

        item_roll_arr 
    end 

    def get_random_item_key
        sum_weights = 0 
        @item_weight_table.each do |key, item_info|
            sum_weights += item_info[:weight] 
        end 

        item_roll_idx = rand(1..sum_weights) - 1 
        item_key = @item_roll_map[item_roll_idx]
        
        item_key
    end 
end 