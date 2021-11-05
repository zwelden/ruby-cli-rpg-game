require "helpers/dice"
require "character/enemy_generator"
require 'items/item_generator'

class Game 
    def get_tile_at_player_x_y(player, map)
        player_x, player_y = player.coords 
        map.get_tile(player_x, player_y)
    end 

    def create_enemies(tile)
        enemy_arr = []
        
        enemy_count = rand(1..3)
        enemy_count.times do
            enemy_arr.push(EnemyGenerator.create_random_enemy())
        end 

        enemy_arr.each do |enemy|
            if (Dice.d10 > 7) 
                gold_amount = Dice.d6 * enemy.level 
                enemy.add_gold(gold_amount)
            end 

            if (Dice.d10 > 8)
                num_items = [Dice.d2, Dice.d2].min
                items = [] 
                num_items.times do 
                    item = ItemGenerator.create_random_item()
                    items.push(item)
                end

                enemy.add_inventory(items)
            end 
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


    def create_treasure(player, tile) 
        gold = (Dice.d10 + Dice.d10) * player.level 
        items = []

        if (Dice.d10 > 6)
            num_items = [Dice.d4, Dice.d4, Dice.d4].min
            
            num_items.times do 
                item = ItemGenerator.create_random_item()
                items.push(item)
            end 
        end 

        tile.load_treasure(gold, items)
    end

    def check_for_treasure(player, map)
        if (player.has_moved? == false)
            return false 
        end 

        tile = get_tile_at_player_x_y(player, map)

        if (tile.has_treasure?)
            return true 
        end 

        treasure_chance = tile.treasure_chance 

        if (Dice.d100 > (100 - treasure_chance))
            create_treasure(player, tile)
            return true 
        end 

        false
    end 
end