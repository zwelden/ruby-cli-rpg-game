class Hero
    attr_reader :name 
    attr_reader :health
    attr_reader :strength 
    attr_reader :defense
    attr_reader :coords

    def initialize(name)
        @name = name
        @max_health = 50
        @health = 50
        @strength = 5
        @defense = 3
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
        restore_health = @max_health / 2 
        increase_health(restore_health)
        puts "You sleep and restore a bit of health"
        puts "Press any key to continue"
        gets
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
            self.setCoords(x_pos, new_y)
        end
    end 

    def move_down(map)
        x_pos, y_pos = @coords
        new_y = y_pos + 1 
        if ( map.inbounds?(x_pos, new_y) && map.is_passible?(x_pos, new_y) )
            self.setCoords(x_pos, new_y)
        end
    end 

    def move_left(map)
        x_pos, y_pos = @coords
        new_x = x_pos - 1 
        if ( map.inbounds?(new_x, y_pos) && map.is_passible?(new_x, y_pos) )
            self.setCoords(new_x, y_pos)
        end
    end 

    def move_right(map)
        x_pos, y_pos = @coords
        new_x = x_pos + 1 
        if ( map.inbounds?(new_x, y_pos) && map.is_passible?(new_x, y_pos) )
            self.setCoords(new_x, y_pos)
        end
    end 
end
