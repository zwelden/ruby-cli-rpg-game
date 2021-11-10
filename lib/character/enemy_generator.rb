require 'character/enemy'
require 'character/enemy_table'

class EnemyGenerator 
    attr_reader :enemy_table

    def initialize
        @enemy_table = EnemyTable.new
    end 
    
    def create_random_enemy 
        create_enemy_from_key(@enemy_table.enemies.keys.sample)
    end 

    def create_enemy_from_key(enemy_key)
        enemy = @enemy_table.get_enemy_info_by_key(enemy_key)
        name = enemy.key?(:name) ? enemy[:name] : 'Unknown enemy'
        health = enemy.key?(:health) ? enemy[:health] : 10
        strength = enemy.key?(:strength) ? enemy[:strength] : 1
        defense = enemy.key?(:defense) ? enemy[:defense] : 1
        level = enemy.key?(:level) ? enemy[:level] : 1
        Enemy.new(name, health, strength, defense, level)
    end 
end