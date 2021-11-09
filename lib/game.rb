require "character/enemy_generator"
require 'character/player'
require 'item/item_generator'
require 'place/shop'
require "map/map_generator"
require 'helpers/dice'
require 'helpers/utilities'
require 'ui/display'
require 'battle'


class Game 
    attr_reader :turn_count
    attr_reader :cooldowns
    attr_reader :player
    attr_reader :map
    attr_reader :game_over
    attr_reader :places_visited

    def initialize
        @game_over = false
        @turn_count = 0 
        @cooldowns = {}
        @places_visited = {}
        @player = Player.generate_new_player
        @map = MapGenerator.generate_new_map(1)

        @player.set_start_position(*map.start_position)
    end

    def increase_turn_count
        @turn_count += 1

        @cooldowns.each do |cooldown, info|
            info[:turns] -= 1
            if info[:turns] <= 0
                @cooldowns.delete(cooldown)
            end 
        end 
    end 

    def add_cooldown(cooldown, turns)
        @cooldowns[cooldown] = {turns: turns}
    end 

    def get_cooldown(cooldown)
        @cooldowns[cooldown]
    end

    def end_game 
        @game_over = true 
    end 

    def render_map_state
        puts @map.render_map(@player)
    end 

    def render_player_info 
        Display.player_info(@player)
    end

    def get_tile_at_player_x_y
        player_x, player_y = @player.coords 
        @map.get_tile(player_x, player_y)
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


    def check_for_battle
        if (@player.has_moved? == false)
            return false 
        end 

        player_x, player_y = @player.coords 

        if (@map.has_enemies?(player_x, player_y))
            return true 
        end 

        tile = @map.get_tile(player_x, player_y)
        enemy_chance = tile.enemy_chance
        
        if (Dice.d100 > (100 - enemy_chance))
            create_enemies(tile)
            return true 
        end 

        false
    end


    def create_treasure(tile) 
        gold = (Dice.d10 + Dice.d10) * @player.level 
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

    def check_for_treasure
        if (@player.has_moved? == false)
            return false 
        end 

        tile = get_tile_at_player_x_y()

        if (tile.has_treasure?)
            return true 
        end 

        treasure_chance = tile.treasure_chance 

        if (Dice.d100 > (100 - treasure_chance))
            create_treasure(tile)
            return true 
        end 

        false
    end 

    def check_for_new_map_load
        tile = get_tile_at_player_x_y()

        if (tile.is_path_to_new_map?)
            return true 
        end 
    end 

    def get_new_map_zone_to_load
        x_pos, y_pos = @player.coords 

        new_map_key = "#{x_pos}_#{y_pos}"
        new_map_zone = @map.gateways[new_map_key]
        
        new_map_zone 
    end
    
    def check_for_shop
        if (player.has_moved? == false)
            return false 
        end 

        tile = get_tile_at_player_x_y()

        return tile.is_shop?
    end 

    def create_shop
        x_pos, y_pos = @player.coords 
        place_key = "#{x_pos}_#{y_pos}"
        shop_detail = @map.places[place_key]
        shop_name = shop_detail[:name]
        shop_max_items = shop_detail[:max_items]
        shop_type = shop_detail[:type]
        shop_level = shop_detail[:level]

        Shop.new(shop_name, shop_max_items, shop_type, shop_level)
    end 

    def get_place_from_places_visited
        map_name = @map.name 
        x_pos, y_pos = @player.coords 
        coords_str = "#{x_pos}_#{y_pos}"

        map_places = @places_visited[map_name]
        if map_places == nil 
            return nil 
        end 

        map_places[coords_str]
    end 

    def add_place_to_places_visited(place)
        map_name = @map.name 
        x_pos, y_pos = @player.coords 
        coords_str = "#{x_pos}_#{y_pos}"

        @places_visited[map_name] ||= {}
        @places_visited[map_name][coords_str] = place 
    end 

    # ************** #
    # GAME SEQUENCES #
    # ************** #

    def new_map_sequence 
        return if @game_over

        has_new_map = check_for_new_map_load()
        if (has_new_map)
            new_map_info = get_new_map_zone_to_load()
            map_zone = new_map_info[:zone]
            start_coords = new_map_info[:entry_coords]
            @map = MapGenerator.generate_new_map(map_zone)

            system "clear"
            puts @map.render_map(@player)
            @player.set_start_position(*start_coords)
        end 
    end 

    def battle_sequence 
        return if @game_over

        has_enemies = check_for_battle()
        if has_enemies
            Animations.battle
            press_any_key_to_continue()
            Battle.new(@player, @map)
            if (@player.is_alive? == false)
                @game_over = true
            end
        end 
    end

    def treasure_sequence 
        return if @game_over

        has_treasure = check_for_treasure()
        if has_treasure
            tile = get_tile_at_player_x_y() 
            treasure = tile.loot_treasure
            gold = treasure[:gold] 
            items = treasure[:items] 
            @player.add_gold(gold)
            @player.add_inventory(items)

            system "clear"
            Display.treasure_found
            puts "You receieved the following loot: "
            puts "Gold: #{gold}"
            puts "Items: "
            items.each do |item|
                puts "- #{item}"
            end 

            press_any_key_to_continue()
        end
    end

    def shop_sequence 
        return if @game_over

        has_shop = check_for_shop()
        if (has_shop)
            shop = get_place_from_places_visited()
            if (shop == nil)
                shop = create_shop()
                add_place_to_places_visited(shop)
                @cooldowns[shop.symbol_ref] = {turns: 10} 
            end 

            if (@cooldowns[shop.symbol_ref] == nil || @cooldowns[shop.symbol_ref][:turns] <= 0)
                shop.reload_items_for_sale() 
                @cooldowns[shop.symbol_ref] = {turns: 10} 
            end 

            system "clear"
            shop.view_place(@player)
        end 
    end 

    def render_state 
        return if @game_over

        system "clear"
        render_map_state()
        render_player_info()
    end 

    def game_sequence 
        new_map_sequence()
        battle_sequence()
        treasure_sequence()
        shop_sequence()
        render_state()
    end 
end