require 'io/console'
require 'helpers/string_colorize'

class Map
    attr_reader :name 
    attr_reader :start_position
    attr_reader :gateways

    def initialize(name, tiles, start_position, map_gateways)
        @name = name
        @tiles = tiles
        @start_position = start_position
        @gateways = map_gateways
    end 

    def inbounds?(x, y) 
        return (y >= 0 && y < @tiles.length && x >= 0 && x < @tiles[y].length)
    end

    def print_map 
        puts @tiles.inspect
    end

    def has_enemies?(x, y)
        tile = @tiles[y][x]
        tile.has_enemies?
    end

    def is_passible?(x, y)
        tile = @tiles[y][x]
        tile.passible 
    end

    def is_path_to_new_map?(x, y)
        tile = @tiles[y][x]
        tile.is_path_to_new_map? 
    end

    def get_tile(x, y)
        @tiles[y][x]
    end

    def render_map(player)
        player_x, player_y = [-1, -1]
        if (player.respond_to?(:coords))
            player_x, player_y = player.coords
        end 
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

        rendered_map = "\n"
        rendered_map << (border_corner_top_l + (border_h * (map_width * 4)) + border_corner_top_r + "\n")

        @tiles.each_with_index do |row, row_idx|
            map_row_line_1 = ""
            map_row_line_2 = ""
            map_row_line_1 << border_v
            map_row_line_2 << border_v
            
            row.each_with_index do |tile, col_idx|
                if (col_idx == player_x && row_idx == player_y)
                    d_line_1, d_line_2 = player.tile.display
                    map_row_line_1 << d_line_1
                    map_row_line_2 << d_line_2
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

        rendered_map << (border_corner_bottom_l + (border_h * (map_width * 4)) + border_corner_bottom_r + "\n")

        rendered_map
    end
end
    