require 'io/console'
require 'helpers/string_colorize'

# Contains the information required to display and navigate a game map
class Map
    attr_reader :name 
    attr_reader :start_position
    attr_reader :gateways
    attr_reader :places
    attr_reader :zone_id

    # Init map
    #
    # @param [string] name - name of the map 
    # @param [:symbol] zone_id
    # @param [array[<Tile>]] tiles - array of Tile object 
    # @param [array[x,y]] start_position - x,y coordinates of default player start position on map
    # @param [hash] map_gateways - exit tiles and destinations 
    # @param [hash] places - coordinantes of interactable places and place detail
    def initialize(name, zone_id, tiles, start_position, map_gateways, places)
        @name = name
        @tiles = tiles
        @start_position = start_position
        @gateways = map_gateways
        @places = places
        @zone_id = zone_id
    end 

    # Determine if a given x,y coordinantes is inbounds for the map 
    #
    # @param [int] x - x coordinate 
    # @param [int] y - y coordinate
    # @return [boolean]
    def inbounds?(x, y) 
        return (y >= 0 && y < @tiles.length && x >= 0 && x < @tiles[y].length)
    end

    # Inspect map tiles by printint to console
    def print_map 
        puts @tiles.inspect
    end

    # Determin if a tile at a given x,y coordinate has preloaded enemies 
    #
    # @param [int] x - x coordinate 
    # @param [int] y - y coordinate 
    # @return [boolean]
    def has_enemies?(x, y)
        tile = @tiles[y][x]
        tile.has_enemies?
    end

    # Determind if a given x,y coordinate is able to be moved to 
    #
    # @param [int] x - x coordinate 
    # @param [int] y - y coordinate 
    # @return [boolean]
    def is_passible?(x, y)
        tile = @tiles[y][x]
        tile.passible 
    end

    # Determind if a given x,y coordinate is a pathway to a new map
    #
    # @param [int] x - x coordinate 
    # @param [int] y - y coordinate 
    # @return [boolean]
    def is_path_to_new_map?(x, y)
        tile = @tiles[y][x]
        tile.is_path_to_new_map? 
    end

    # Get the tile found at a given x,y coordinate
    #
    # @param [int] x - x coordinate 
    # @param [int] y - y coordinate 
    # @return [<Tile>]
    def get_tile(x, y)
        @tiles[y][x]
    end

    # Display map in the terminal
    #
    # @param [<Player>] player
    def render_map(player)
        player_x, player_y = [-1, -1]
        if (player.respond_to?(:coords))
            player_x, player_y = player.coords
        end 
        map_width = @tiles[0].length
        map_width_ch_len = map_width * 4
        win_height, win_width = IO.console.winsize
        lpad = (win_width - (map_width + 2)) / 2 
        lpad_str = " " * lpad

        wall = "\u2588"
        border_h = "═"
        border_v = "║"
        border_corner_top_r = "╗"
        border_corner_top_l = "╔"
        border_corner_bottom_r = "╝"
        border_corner_bottom_l = "╚"

        rendered_map = "\n"
        rendered_map << (border_corner_top_l + (border_h * map_width_ch_len) + border_corner_top_r + "\n")
        rendered_map << border_v + " #{@name}".ljust(map_width_ch_len).colorize("cyan") + border_v + "\n"
        rendered_map << (border_corner_bottom_l + (border_h * map_width_ch_len) + border_corner_bottom_r + "\n")
        rendered_map << (border_corner_top_l + (border_h * map_width_ch_len) + border_corner_top_r + "\n")

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

        rendered_map << (border_corner_bottom_l + (border_h * map_width_ch_len) + border_corner_bottom_r + "\n")

        rendered_map
    end
end
    