require 'json'

# Loads the contents of the enemy table json file into a holding object for querying
# The enemy table will contain all enemies that can be dynamically generated
class EnemyTable
    TABLE_FILE_PATH = File.expand_path(File.dirname(__FILE__)) + '/tables'

    attr_reader :enemies

    # Load the json file into the enemies hash variable
    def initialize
        file_path = TABLE_FILE_PATH + '/enemy_table.json'
        file = File.read(file_path)
        @enemies = JSON.parse(file, {symbolize_names: true})
    end 

    # Get a hash object representing an enemy by was of a key symbol 
    #
    # @param [symbol] key - symbol value representing an enemy
    def get_enemy_info_by_key(key)
        enemy = nil

        if @enemies.has_key?(key)
            enemy = @enemies[key]
        end 

        enemy
    end 
end 
