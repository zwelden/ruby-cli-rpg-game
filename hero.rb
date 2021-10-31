class Hero
    attr_reader :name 
    attr_reader :health
    attr_reader :strength 
    attr_reader :defense
    attr_reader :coords

    def initialize(name)
        @name = name
        @health = 25
        @stregth = 5
        @defense = 3
        @coords = [0,0]
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
