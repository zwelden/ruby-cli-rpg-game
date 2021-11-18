require "character/enemy_generator"
require 'character/enemy_zone_table'
require 'character/player'
require 'item/item_generator'
require 'place/shop'
require "map/map_generator"
require 'helpers/dice'
require 'helpers/utilities'
require 'ui/display'
require 'battle'

# Class for managing game player and game event loops
class Game 
    attr_reader :turn_count
    attr_reader :cooldowns
    attr_reader :player
    attr_reader :map
    attr_reader :game_over
    attr_reader :places_visited
    attr_reader :enemy_generator
    attr_reader :enemy_zone_table

    # Init
    def initialize
        @game_over = false
        @turn_count = 0 
        @cooldowns = {}
        @places_visited = {}
        @player = Player.generate_new_player
        @map = MapGenerator.generate_new_map(1)
        @enemy_generator = EnemyGenerator.new
        @enemy_zone_table = EnemyZoneTable.new(@map.zone_id)

        @player.set_start_position(*map.start_position)
    end

    # Increment the turn count and update all game cooldowns
    def increase_turn_count
        @turn_count += 1

        @cooldowns.each do |cooldown, info|
            info[:turns] -= 1
            if info[:turns] <= 0
                @cooldowns.delete(cooldown)
            end 
        end 
    end 

    # Add a cooldown to the @cooldowns hash 
    #
    # @param [symbol] cooldown 
    # @param [int] turns - how long cooldown lasts in # of turns
    def add_cooldown(cooldown, turns)
        @cooldowns[cooldown] = {turns: turns}
    end 

    # get a cooldown info from symbol 
    #
    # @param [symbol] cooldown 
    # @return [hash] {turns: [int]}
    def get_cooldown(cooldown)
        @cooldowns[cooldown]
    end

    # Set game_over state to true 
    def end_game 
        @game_over = true 
    end 

    # Display the game map 
    def render_map_state
        puts @map.render_map(@player)
    end 

    # Display summary info about player
    def render_player_info 
        Display.player_info(@player)
    end

    # Get the Map Tile found at the player's x,y coordinates 
    #
    # @return [<Tile>]
    def get_tile_at_player_x_y
        player_x, player_y = @player.coords 
        @map.get_tile(player_x, player_y)
    end 

    # Get a random number of enemies between 1-3 weighted in favor of fewer enemies
    def get_num_enemies 
        enemy_roll = Dice.d10 
        if (enemy_roll == 10)
            3 
        elsif (enemy_roll >= 6)
            2 
        else  
            1 
        end 
    end

    # Create ranomd enemies and then add to given tile 
    #
    # @param [<tile>] tile 
    def create_enemies(tile)
        enemy_arr = []
        
        enemy_count = get_num_enemies()

        enemy_count.times do
            enemy_key = @enemy_zone_table.get_random_enemy_key(tile.type_to_symbol())
            enemy = @enemy_generator.create_enemy_from_key(enemy_key)
            enemy_arr.push(enemy)
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
                    item = ItemGenerator.create_random_item_by_enemy_level(enemy.level)
                    items.push(item)
                end

                enemy.add_inventory(items)
            end 
        end

        tile.load_enemies(enemy_arr)
    end

    # Determine if current player x,y position can have a battle instantiated 
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

    # Create a random treasure and add it to the given tile 
    #
    # @param [<Tile>] Tile
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

    # Determine if the current player x,y position can have a treasure event instantiated
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

    # Determine if current player x,y requires loading a new map 
    #
    # @return [boolean]
    def check_for_new_map_load
        tile = get_tile_at_player_x_y()

        if (tile.is_path_to_new_map?)
            return true 
        end 
    end 

    # Determine which map to load based on @map.gateways hash 
    #
    # @param [string|int] - symbol coresponing to new map zone
    def get_new_map_zone_to_load
        x_pos, y_pos = @player.coords 

        new_map_key = "#{x_pos}_#{y_pos}"
        new_map_zone = @map.gateways[new_map_key]
        
        new_map_zone 
    end
    
    # Determine if current player x,y requires instantinating a shop instance 
    #
    # @return [boolean]
    def check_for_shop
        if (player.has_moved? == false)
            return false 
        end 

        tile = get_tile_at_player_x_y()

        return tile.is_shop?
    end 

    # Generate a new shop class based on current player x,y position 
    #
    # @return [<Shop>]
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

    # Check @places_visted to see if current player x,y position corresponds to an already instantiated place 
    #
    # @return [<Place>|nil]
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

    # Add place object to @places_visited hash 
    # 
    # @param [<Place>] place
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

    # Game loop for handling new map loading
    def new_map_sequence 
        return if @game_over

        has_new_map = check_for_new_map_load()
        if (has_new_map)
            new_map_info = get_new_map_zone_to_load()
            map_zone = new_map_info[:zone]
            start_coords = new_map_info[:entry_coords]
            @map = MapGenerator.generate_new_map(map_zone)
            @enemy_zone_table = EnemyZoneTable.new(@map.zone_id)

            system "clear"
            puts @map.render_map(@player)
            @player.set_start_position(*start_coords)
        end 
    end 

    # Game loop for handling battle events
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

    # Game loop for handing treasure events
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

    # Game loop for handling shop visits 
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

    # Display update game state/map
    def render_state 
        return if @game_over

        system "clear"
        render_map_state()
        render_player_info()
    end 

    # Main loop
    def game_sequence 
        new_map_sequence()
        battle_sequence()
        treasure_sequence()
        shop_sequence()
        render_state()
    end 
end