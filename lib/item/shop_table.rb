require 'json'

# Loads the contents of a shop table json file into a holding object for querying
# The shop table loaded will contain all items that can be dynamically generated for a given shop
class ShopTable 
    TABLE_FILE_PATH = File.expand_path(File.dirname(__FILE__)) + '/tables'

    attr_reader :item_weight_table
    attr_reader :item_roll_map

    # intalizes the shop table based on shop type and level
    #
    # @param [string] type - type of shop, ex: "generic", "weapon", "armor", etc
    # @param [int] level
    def initialize(type, level)
        file_path = TABLE_FILE_PATH + "/#{type}_level_#{level}_shop_table.json"
        file = File.read(file_path)
        @item_weight_table = JSON.parse(file, {symbolize_names: true})
        @item_roll_map = generate_item_roll_map()
    end 

    # Generates an array that maps a index value to an item key 
    # with number of occurances of an item in the array dictated by the item's weight
    # index value will be used in a random slection
    #
    # @return [array]
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

    # returns a ranom item symbol
    #
    # @return [symbol] - item symbol seving as a key value for an item table
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