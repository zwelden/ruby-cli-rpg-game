require "./dice.rb"

class Game 
    def create_monsters(tile)

        monsters = [["Bandit", 10, 2, 2], ["Goul", 10, 1, 1], ["Rat", 5, 5, 1], ["Skeleton", 10, 5, 1], ["Zombie", 20, 3, 2]]
        monster_arr = []
        
        monster_count = rand(1..3)
        monster_count.times do
            monster_info = monsters.sample
            monster_arr.push(Monster.new(*monster_info))
        end 

        tile.load_monsters(monster_arr)
    end


    def check_for_battle(player, map)
        player_x, player_y = player.coords 

        if (map.has_monsters?(player_x, player_y))
            return true 
        end 

        tile = map.get_tile(player_x, player_y)
        monster_chance = tile.monster_chance
        
        if (Dice.d100 > (100 - monster_chance))
            create_monsters(tile)
            return true 
        end 

        false
    end
end