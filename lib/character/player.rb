require "helpers/utilities"
require 'ui/display'
require "ui/animations"
require "character/character"
require 'game_log'

class Player < Character
    attr_reader :coords
    attr_reader :prev_coords
    attr_reader :recently_slept
    attr_reader :experience

    def initialize(name)
        super(name, 50, 6, 3, 1, gold: 10)

        @experience = 0
        @recently_slept = false
        @recently_slept_move_counter = 0
        @coords = [0,0]

        # @logger = GameLog.new 
    end

    def self.generate_new_player
        print "Choose a name for your character: "
        player_name = gets.chomp.strip
        return Player.new(player_name)
    end

    def sleep 
        update_prev_coords_from_current_position()

        if (@recently_slept == true)
            puts "You have recently slept, you need to move around a bit before you can sleep again"
            press_any_key_to_continue()
            return
        end 

        restore_health = @max_health / 2 
        increase_health(restore_health)
        @recently_slept = true
        @recently_slept_move_counter = 3
        Animations.sleep_player()
        puts "You sleep and restore a bit of health"
        press_any_key_to_continue()
    end
    
    def decrement_recent_sleep
        @recently_slept_move_counter -= 1

        if (@recently_slept_move_counter <= 0)
            @recently_slept_move_counter = 0
            @recently_slept = false 
        end 
    end 

    def show_inventory 
        update_prev_coords_from_current_position()

        system "clear"
        Display.show_inventory(self)
    end 

    def increase_experience(amount)
        puts "+ #{amount} experience gained"
        @experience += amount 
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
            decrement_recent_sleep()
        end
    end 

    def move_down(map)
        x_pos, y_pos = @coords

        new_y = y_pos + 1 
        if ( map.inbounds?(x_pos, new_y) && map.is_passible?(x_pos, new_y) )
            set_coords(x_pos, new_y)
            decrement_recent_sleep()
        end
    end 

    def move_left(map)
        x_pos, y_pos = @coords

        new_x = x_pos - 1 
        if ( map.inbounds?(new_x, y_pos) && map.is_passible?(new_x, y_pos) )
            set_coords(new_x, y_pos)
            decrement_recent_sleep()
        end
    end 

    def move_right(map)
        x_pos, y_pos = @coords

        new_x = x_pos + 1 
        if ( map.inbounds?(new_x, y_pos) && map.is_passible?(new_x, y_pos) )
            set_coords(new_x, y_pos)
            decrement_recent_sleep()
        end
    end 
end
