require 'json'

# This class loads a json file representing the enemies avalible to the tiles of a 
# given map zone into a weighted table for use in randomly generating enemies
class EnemyZoneTable 
    TABLE_FILE_PATH = File.expand_path(File.dirname(__FILE__)) + '/tables'

    attr_reader :enemy_weight_table
    attr_reader :enemy_roll_map

    # load the json file associated with the target zone and 
    # assign the weight table and roll map
    def initialize(zone)
        file_path = TABLE_FILE_PATH + "/#{zone}_enemy_table.json"
        file = File.read(file_path)
        @enemy_weight_table = JSON.parse(file, {symbolize_names: true})
        @enemy_roll_map = generate_enemy_roll_map()
    end 

    # creates the roll map 
    # used to match a randomly rolled int with an enemy key symbol
    def generate_enemy_roll_map
        enemy_tile_roll_map = {}
        @enemy_weight_table.each do |tile, enemies|
            enemy_roll_arr = []
            enemies.each do |enemy_key, enemy_info|
                weight = enemy_info[:weight] 
                weight.times do 
                    enemy_roll_arr.push(enemy_key)
                end 
            end
            enemy_tile_roll_map[tile] = enemy_roll_arr
        end 

        enemy_tile_roll_map 
    end 

    # Get a random enemy key symbol by tile type 
    # 
    # @param [symbol] tile_type 
    # @return [symbol] - symbol representing an enemy, matches to the enemies avaliable in the EnemyTable class
    def get_random_enemy_key(tile_type)
        return nil if (@enemy_weight_table[tile_type] == nil)

        sum_weights = 0 
        @enemy_weight_table[tile_type].each do |key, enemy_info|
            sum_weights += enemy_info[:weight] 
        end 

        enemy_roll_idx = rand(1..sum_weights) - 1 
        enemy_key = @enemy_roll_map[tile_type][enemy_roll_idx]
        
        enemy_key
    end 
end 