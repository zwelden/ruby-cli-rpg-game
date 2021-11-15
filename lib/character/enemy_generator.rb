require 'character/enemy'
require 'character/enemy_table'

# Uses the EnemyTable to create enemies based on the paired enemy key in the EnemyTable
class EnemyGenerator 
    attr_reader :enemy_table

    # Create an enemy table on init
    def initialize
        @enemy_table = EnemyTable.new
    end 
    
    # Get a random enemy key symbol from the enemy table
    def create_random_enemy 
        create_enemy_from_key(@enemy_table.enemies.keys.sample)
    end 

    # Create an Enemy object from an enemy key symbol 
    #
    # @param [symbol] enemy_key
    def create_enemy_from_key(enemy_key)
        enemy = @enemy_table.get_enemy_info_by_key(enemy_key)
        return nil if (enemy.nil?)

        name = enemy.key?(:name) ? enemy[:name] : 'Unknown enemy'
        health = enemy.key?(:health) ? enemy[:health] : 10
        strength = enemy.key?(:strength) ? enemy[:strength] : 1
        defense = enemy.key?(:defense) ? enemy[:defense] : 1
        level = enemy.key?(:level) ? enemy[:level] : 1
        Enemy.new(name, health, strength, defense, level)
    end 
end