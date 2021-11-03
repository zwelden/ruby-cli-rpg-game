require "helpers/dice"
require "character/enemy_generator"

class Game 
    def create_enemies(tile)
        enemy_arr = []
        
        enemy_count = rand(1..3)
        enemy_count.times do
            enemy_arr.push(EnemyGenerator.create_random_enemy())
        end 

        tile.load_enemies(enemy_arr)
    end


    def check_for_battle(player, map)
        if (player.has_moved? == false)
            return false 
        end 

        player_x, player_y = player.coords 

        if (map.has_enemies?(player_x, player_y))
            return true 
        end 

        tile = map.get_tile(player_x, player_y)
        enemy_chance = tile.enemy_chance
        
        if (Dice.d100 > (100 - enemy_chance))
            create_enemies(tile)
            return true 
        end 

        false
    end
end