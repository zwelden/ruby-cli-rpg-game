require "helpers/utilities"
require 'ui/display'
require "ui/animations"
require "character/character"
require 'io/console'
require 'item/weapon'
require 'item/armor'
require 'map/tile'
require 'game_log'
require 'helpers/string_colorize'

class Player < Character
    attr_reader :coords
    attr_reader :prev_coords
    attr_reader :experience
    attr_reader :tile

    def initialize(name)
        super(name, 50, 6, 3, 1, gold: 10)

        @experience = 0
        @coords = [0,0]
        @tile = Tile.new('player')

        @weapon_slot = Weapon.new("Rusty Dagger", 2, {power: 1})
        @body_slot = Armor.new("Old Cloth Tunic", 2, {armor: 1, armor_type: "body"})
        @leg_slot = Armor.new("Old Cloth Pants", 2, {armor: 1, armor_type: "legs"})
        # @logger = GameLog.new 
    end

    def self.generate_new_player
        STDIN.iflush()
        print "Choose a name for your character: "
        player_name = gets.chomp.strip
        return Player.new(player_name)
    end

    def sleep 
        update_prev_coords_from_current_position()
        restore_health = @max_health / 2 
        increase_health(restore_health)
        Animations.sleep_player()
        puts "You sleep and restore a bit of health"
        press_any_key_to_continue()
    end

    def show_inventory 
        update_prev_coords_from_current_position()

        system "clear"
        Display.player_inventory(self)
        press_any_key_to_continue()
    end 

    def show_full_detail 
        update_prev_coords_from_current_position()

        system "clear"
        Display.full_player_info(self)
    end 

    def increase_experience(amount)
        @experience += amount 
        can_level_up = @experience >= next_level_experience() 
        increase_exp_str = "+ #{amount}".colorize("cyan")
        puts "#{increase_exp_str} experience gained"

        if (can_level_up)
            level_up() 
            puts "You leveled up! You are now level: #{@level.to_s.colorize("cyan")}"
        end 
    end 
  
    def increase_level 
        @level += 1
    end

    def set_start_position(new_x, new_y)
        @prev_coords = [new_x, new_y]
        @coords = [new_x, new_y]
    end

    def set_coords(new_x, new_y)
        @coords = [new_x, new_y]
    end

    def update_prev_coords_from_current_position()
        x_pos, y_pos = @coords
        @prev_coords = [x_pos, y_pos]
    end 

    def next_level_experience()
        return 50 + (25 * (@level ** 2))
    end

    def level_up
        @level += 1
        @strength += 2 
        @defense += 1
        @max_health += 15 
        @health = @max_health 
    end 


    def has_moved? 
        prev_x, prev_y = @prev_coords 
        curr_x, curr_y = @coords 

        if (prev_x == curr_x && prev_y == curr_y)
            false 
        else 
            true
        end 
    end 

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

    def move_up(map)
        x_pos, y_pos = @coords

        new_y = y_pos - 1 
        if ( map.inbounds?(x_pos, new_y) && map.is_passible?(x_pos, new_y) )
            set_coords(x_pos, new_y)
        end
    end 

    def move_down(map)
        x_pos, y_pos = @coords

        new_y = y_pos + 1 
        if ( map.inbounds?(x_pos, new_y) && map.is_passible?(x_pos, new_y) )
            set_coords(x_pos, new_y)
        end
    end 

    def move_left(map)
        x_pos, y_pos = @coords

        new_x = x_pos - 1 
        if ( map.inbounds?(new_x, y_pos) && map.is_passible?(new_x, y_pos) )
            set_coords(new_x, y_pos)
        end
    end 

    def move_right(map)
        x_pos, y_pos = @coords

        new_x = x_pos + 1 
        if ( map.inbounds?(new_x, y_pos) && map.is_passible?(new_x, y_pos) )
            set_coords(new_x, y_pos)
        end
    end 
end
