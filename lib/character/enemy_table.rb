require 'json'

class EnemyTable
    TABLE_FILE_PATH = File.expand_path(File.dirname(__FILE__)) + '/tables'

    attr_reader :enemies

    def initialize
        file_path = TABLE_FILE_PATH + '/enemy_table.json'
        file = File.read(file_path)
        @enemies = JSON.parse(file, {symbolize_names: true})
    end 

    def get_enemy_info_by_key(key)
        enemy = nil

        if @enemies.has_key?(key)
            enemy = @enemies[key]
        end 

        enemy
    end 
end 
