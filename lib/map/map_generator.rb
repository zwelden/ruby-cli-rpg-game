require 'map/map'
require "map/tile"
require "character/enemy"

class MapGenerator 

    MAP_1 = {
        tiles: [
            ["g", "g", "g", "g", "g", "g", "g", "g", "g", "g", "m", "m", "m", "m", "g", "g", "g", "g", "g", "f"],
            ["g", "g", "g", "g", "f", "f", "g", "g", "g", "g", "g", "m", "m", "m", "g", "g", "g", "g", "f", "f"],
            ["g", "g", "g", "f", "f", "g", "g", "g", "g", "g", "g", "g", "m", "g", "g", "g", "g", "f", "f", "f"],
            ["g", "g", "g", "g", "f", "g", "g", "g", "g", "g", "g", "g", "g", "g", "g", "g", "f", "f", "f", "f"],
            ["g", "g", "g", "f", "f", "g", "g", "w", "w", "w", "g", "g", "g", "g", "g", "g", "f", "f", "f", "f"],
            ["g", "g", "g", "g", "g", "g", "g", "w", "w", "w", "w", "g", "x", "x", "g", "x", "x", "f", "f", "f"],
            ["m", "g", "g", "g", "g", "g", "w", "w", "w", "w", "g", "g", "x", "g", "g", "g", "x", "g", "f", "f"],
            ["m", "m", "g", "g", "g", "g", "g", "g", "g", "g", "g", "g", "x", "g", "h", "g", "x", "g", "g", "f"],
            ["m", "m", "m", "g", "g", "g", "g", "g", "g", "g", "g", "g", "x", "x", "x", "x", "x", "g", "g", "f"],
            ["m", "m", "m", "m", "g", "g", "g", "g", "g", "g", "g", "g", "g", "g", "g", "g", "g", "g", "g", "g"]
        ],
        map_name: "Level 1",
        start_position: [0,0]
    }

    MAP_2 = {
        tiles: [
            ["g", "g", "g", "g"],
            ["g", "g", "g", "g"],
            ["g", "g", "g", "g"],
            ["g", "g", "g", "g"]
        ],
        map_name: "Level 2",
        start_position: [3,3]
    }

    def self.generate_map_tiles(tile_detail)
        tiles = []

        tile_detail.each do |row|
            tile_row = []
            row.each do |tile_type|
                enemy_arr = []
                # load preset enemies 
                tile_row.push(Tile.new(tile_type, enemy_arr))
            end 
            tiles.push(tile_row)
        end 

        tiles
    end

    def self.generate_new_map(map_level)
        map_template = case map_level
            when 1
                MAP_1
            when 2
                MAP_2
            else
                MAP_1
            end

        tiles = self.generate_map_tiles(map_template[:tiles])
        map_name = map_template[:map_name]
        start_position = map_template[:start_position]

        Map.new(map_name, tiles, start_position)
    end
end