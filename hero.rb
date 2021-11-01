require "./utilities.rb"
require "./animations.rb"

class Hero
    attr_reader :name 
    attr_reader :health
    attr_reader :strength 
    attr_reader :defense
    attr_reader :coords
    attr_reader :recently_slept
    attr_reader :experience
    attr_reader :level

    def initialize(name)
        @name = name
        @max_health = 50
        @health = 50
        @strength = 5
        @defense = 3
        @experience = 0
        @level = 1
        @recently_slept = false
        @recently_slept_move_counter = 0
        @coords = [0,0]
    end

    def reduce_health(amount)
        @health -= amount 
        if (@health < 0)
            @health = 0 
        end
    end 

    def increase_health(amount)
        @health += amount 
        if (@health > @max_health)
            @health = @max_health
        end 
    end 

    def sleep 
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

    def increase_experience(amount)
        puts "+ #{amount} experience gained"
        @experience += amount 
    end 
  
    def increase_level 
        @level += 1
    end

    def is_alive? 
        return @health > 0
    end 

    def setCoords(newX, newY)
        @coords = [newX, newY]
    end

    def move_up(map)
        x_pos, y_pos = @coords
        new_y = y_pos - 1 
        if ( map.inbounds?(x_pos, new_y) && map.is_passible?(x_pos, new_y) )
            setCoords(x_pos, new_y)
            decrement_recent_sleep()
        end
    end 

    def move_down(map)
        x_pos, y_pos = @coords
        new_y = y_pos + 1 
        if ( map.inbounds?(x_pos, new_y) && map.is_passible?(x_pos, new_y) )
            setCoords(x_pos, new_y)
            decrement_recent_sleep()
        end
    end 

    def move_left(map)
        x_pos, y_pos = @coords
        new_x = x_pos - 1 
        if ( map.inbounds?(new_x, y_pos) && map.is_passible?(new_x, y_pos) )
            setCoords(new_x, y_pos)
            decrement_recent_sleep()
        end
    end 

    def move_right(map)
        x_pos, y_pos = @coords
        new_x = x_pos + 1 
        if ( map.inbounds?(new_x, y_pos) && map.is_passible?(new_x, y_pos) )
            setCoords(new_x, y_pos)
            decrement_recent_sleep()
        end
    end 
end
