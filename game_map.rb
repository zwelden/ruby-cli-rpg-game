require 'io/console'
require './string_colorize.rb'

class GameMap
    def initialize(tiles)
        @tiles = tiles
    end 

    def inbounds?(x, y) 
        return (y >= 0 && y < @tiles.length && x >= 0 && x < @tiles[y].length)
    end

    def print_map 
        puts @tiles.inspect
    end

    def has_monsters?(x, y)
        tile = @tiles[y][x]
        tile.has_monsters?
    end

    def is_passible?(x, y)
        tile = @tiles[y][x]
        tile.passible 
    end

    def get_tile(x, y)
        @tiles[y][x]
    end

    def render_map(player)
        player_x, player_y = player.coords
        map_width = @tiles[0].length
        win_height, win_width = IO.console.winsize
        lpad = (win_width - (map_width + 2)) / 2 
        lpad_str = " " * lpad

        wall = "\u2588"
        border_h = "\u2550"
        border_v = "\u2551"
        border_corner_top_r = "\u2557"
        border_corner_top_l = "\u2554"
        border_corner_bottom_r = "\u255D"
        border_corner_bottom_l = "\u255A"

        rendered_map = "\n\n\n\n\n"
        rendered_map << (border_corner_top_l + (border_h * (map_width * 3)) + border_corner_top_r + "\n")

        @tiles.each_with_index do |row, row_idx|
            map_row_line_1 = ""
            map_row_line_2 = ""
            map_row_line_1 << border_v
            map_row_line_2 << border_v
            
            row.each_with_index do |tile, col_idx|
                if (col_idx == player_x && row_idx == player_y)
                    map_row_line_1 << "^X^".colorize("black").colorize("bg_white")
                    map_row_line_2 << "X^X".colorize("black").colorize("bg_white")
                else 
                    d_line_1, d_line_2 = tile.display
                    map_row_line_1 << d_line_1
                    map_row_line_2 << d_line_2
                end                
            end 
            
            map_row_line_1 << border_v
            map_row_line_2 << border_v
            rendered_map << (map_row_line_1 + "\n")
            rendered_map << (map_row_line_2 + "\n")
        end 

        rendered_map << (border_corner_bottom_l + (border_h * (map_width * 3)) + border_corner_bottom_r + "\n")

        rendered_map
    end
end
    