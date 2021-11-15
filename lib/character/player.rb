require "helpers/utilities"
require 'ui/display'
require "ui/animations"
require "character/character"
require 'io/console'
require 'item/weapon'
require 'item/armor'
require 'map/tile'
require 'helpers/string_colorize'

# This class represents a player playing the game 
class Player < Character
    attr_reader :coords
    attr_reader :prev_coords
    attr_reader :experience
    attr_reader :tile

    # Initialize the player 
    #
    # @param [string] name - name to give the player
    def initialize(name)
        super(name, 50, 6, 3, 1, gold: 10)

        @experience = 0
        @coords = [0,0]
        @prev_coords = [0,0]
        @tile = Tile.new('player')

        @weapon_slot = Weapon.new("Rusty Dagger", 2, {power: 1})
        @body_slot = Armor.new("Old Cloth Tunic", 2, {armor: 1, armor_type: "body"})
        @leg_slot = Armor.new("Old Cloth Pants", 2, {armor: 1, armor_type: "legs"})
    end

    # generates a new player by prompting the user for a name to create a player with 
    def self.generate_new_player
        STDIN.iflush()
        print "Choose a name for your character: "
        player_name = gets.chomp.strip
        return Player.new(player_name)
    end

    # restores half the player's max health and displays a "sleeping" animation
    #
    # @param [boolean] show_animation - used to disable output during testing by setting to false
    def sleep(show_animation: true)
        update_prev_coords_from_current_position()
        restore_health = @max_health / 2 
        increase_health(restore_health)

        if (show_animation == true)
            Animations.sleep_player()
            puts "You sleep and restore a bit of health"
            press_any_key_to_continue()
        end 
    end

    # Display the contents of the player's inventory
    # NOTE: untested
    def show_inventory 
        update_prev_coords_from_current_position()

        system "clear"
        Display.player_inventory(self)
        press_any_key_to_continue()
    end 

    # Display information about all aspecpts of the player: equipped items, inventory, health, exp, etc
    # NOTE: untested
    def show_full_detail 
        update_prev_coords_from_current_position()

        system "clear"
        Display.full_player_info(self)
    end 

    # Calculate experience needed to level up based on current level
    def next_level_experience
        return 50 + (25 * (@level ** 2))
    end

    # Increase the amount of the player's experience, check level increase, and increase level if required
    #
    # @param [int] amount
    def increase_experience(amount, display_output: true)
        @experience += amount 
        increase_exp_str = "+ #{amount}".colorize("cyan")

        if (display_output == true)
            puts "#{increase_exp_str} experience gained"
        end 

        while (@experience >= next_level_experience())
            level_up() 
            if (display_output == true)
                puts "You leveled up! You are now level: #{@level.to_s.colorize("cyan")}"
            end 
        end 
    end 
  
    # Level up a player one level and update variables associated with a level up
    def level_up
        @level += 1
        @strength += 2 
        @defense += 1
        @max_health += 15 
        @health = @max_health 
    end 

    # Set/reset the intial x,y position of the player 
    #
    # @param [int] nex_x 
    # @param [int] new_y
    def set_start_position(new_x, new_y)
        @prev_coords = [new_x, new_y]
        @coords = [new_x, new_y]
    end

    # Set the current position of the player 
    #
    # @param [int] nex_x 
    # @param [int] new_y
    def set_coords(new_x, new_y)
        @coords = [new_x, new_y]
    end

    # Copy current x,y position to @prev_coords variable
    def update_prev_coords_from_current_position
        x_pos, y_pos = @coords
        @prev_coords = [x_pos, y_pos]
    end 

    # Determine if a player has moved by comparing @coords to @prev_coords
    def has_moved? 
        prev_x, prev_y = @prev_coords 
        curr_x, curr_y = @coords 

        if (prev_x == curr_x && prev_y == curr_y)
            false 
        else 
            true
        end 
    end 

    # Move handler 
    #
    # @param [<Map>] map - map on which valid moves are evaluated 
    # @param [symbol] direction - valid inputs: [:up, :down, :left, :right]
    def move(map, direction)
        update_prev_coords_from_current_position()

        case direction
        when :up
            move_up(map)

        when :down
            move_down(map) 

        when :left
            move_left(map) 

        when :right
            move_right(map) 
        end
    end

    # Move the player's x,y coordinants "up"
    #
    # @param [<Map>] map - map on which valid moves are evaluated 
    def move_up(map)
        x_pos, y_pos = @coords

        new_y = y_pos - 1 
        if ( map.inbounds?(x_pos, new_y) && map.is_passible?(x_pos, new_y) )
            set_coords(x_pos, new_y)
        end
    end 

    # Move the player's x,y coordinants "down"
    #
    # @param [<Map>] map - map on which valid moves are evaluated 
    def move_down(map)
        x_pos, y_pos = @coords

        new_y = y_pos + 1 
        if ( map.inbounds?(x_pos, new_y) && map.is_passible?(x_pos, new_y) )
            set_coords(x_pos, new_y)
        end
    end 

    # Move the player's x,y coordinants "left"
    #
    # @param [<Map>] map - map on which valid moves are evaluated 
    def move_left(map)
        x_pos, y_pos = @coords

        new_x = x_pos - 1 
        if ( map.inbounds?(new_x, y_pos) && map.is_passible?(new_x, y_pos) )
            set_coords(new_x, y_pos)
        end
    end 

    # Move the player's x,y coordinants "right"
    #
    # @param [<Map>] map - map on which valid moves are evaluated 
    def move_right(map)
        x_pos, y_pos = @coords

        new_x = x_pos + 1 
        if ( map.inbounds?(new_x, y_pos) && map.is_passible?(new_x, y_pos) )
            set_coords(new_x, y_pos)
        end
    end 
end
