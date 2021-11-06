require 'map/map'
require "map/tile"
require "character/enemy"

class MapGenerator 

    MAP_1 = {
        tiles: [
            ["e", "e", "e", "e", "e", "e", "e", "e", "e", "e", "e", "e", "e", "e", "e", "e", "e", "R", "e", "e", "e", "e", "e"],
            ["e", "g", "g", "g", "f", "f", "g", "g", "g", "g", "g", "m", "m", "m", "g", "g", "r", "r", "f", "f", "f", "f", "e"],
            ["R", "r", "r", "f", "f", "g", "g", "g", "g", "g", "g", "g", "m", "g", "g", "g", "r", "f", "f", "f", "f", "f", "e"],
            ["e", "g", "r", "r", "r", "r", "r", "r", "r", "r", "r", "g", "g", "g", "g", "g", "r", "f", "f", "f", "f", "f", "e"],
            ["e", "g", "g", "f", "f", "g", "g", "w", "w", "w", "r", "r", "r", "r", "r", "r", "r", "f", "f", "f", "f", "f", "e"],
            ["e", "g", "g", "g", "g", "g", "g", "w", "w", "w", "w", "r", "x", "x", "r", "x", "x", "f", "f", "f", "f", "f", "e"],
            ["e", "g", "g", "g", "g", "g", "w", "w", "w", "w", "g", "r", "x", "g", "r", "g", "x", "g", "f", "f", "f", "f", "e"],
            ["e", "m", "g", "g", "g", "g", "g", "g", "g", "g", "g", "r", "x", "g", "h", "g", "x", "g", "g", "g", "f", "f", "e"],
            ["e", "m", "m", "g", "g", "g", "g", "g", "g", "g", "g", "r", "x", "x", "x", "x", "x", "g", "g", "f", "f", "f", "e"],
            ["e", "m", "m", "m", "g", "g", "g", "g", "g", "g", "g", "r", "g", "g", "g", "g", "g", "f", "f", "f", "f", "f", "e"],
            ["e", "m", "m", "m", "g", "g", "g", "w", "w", "w", "r", "r", "g", "g", "g", "g", "g", "f", "f", "f", "f", "f", "e"],
            ["e", "m", "m", "g", "g", "g", "w", "w", "w", "w", "r", "g", "g", "g", "g", "g", "g", "g", "f", "f", "f", "f", "e"],
            ["e", "m", "g", "g", "g", "g", "g", "g", "g", "r", "r", "g", "g", "g", "g", "g", "g", "g", "g", "g", "f", "g", "e"],
            ["e", "m", "m", "g", "g", "g", "g", "g", "g", "r", "g", "g", "g", "g", "g", "g", "g", "g", "g", "f", "f", "g", "e"],
            ["e", "m", "m", "g", "g", "g", "g", "g", "g", "r", "g", "g", "g", "g", "g", "g", "g", "g", "g", "g", "g", "g", "e"],
            ["e", "e", "e", "e", "e", "e", "e", "e", "e", "R", "e", "e", "e", "e", "e", "e", "e", "e", "e", "e", "e", "e", "e"]
        ],
        map_name: "Zone 1",
        start_position: [14,4],
        map_gateways: {
            '0_2' => {
                zone: 3,
                entry_coords: [0,0]
            },
            '17_0' => {
                zone: 2,
                entry_coords: [17,14]
            },
            '9_15' => {
                zone: 4,
                entry_coords: [0,0]
            }
        }
    }

    MAP_2 = {
        tiles: [
            ["e", "e", "e", "e", "e", "e", "e", "e", "e", "e", "e", "e", "e", "e", "e", "e", "e", "e", "e", "e", "e", "e", "e"],
            ["e", "g", "m", "m", "m", "m", "m", "m", "m", "m", "m", "m", "m", "m", "f", "f", "f", "f", "f", "f", "f", "f", "e"],
            ["e", "g", "g", "m", "m", "m", "m", "m", "m", "m", "m", "m", "m", "f", "f", "f", "f", "f", "f", "f", "f", "f", "e"],
            ["R", "r", "g", "g", "m", "m", "m", "m", "m", "m", "m", "m", "f", "f", "f", "f", "f", "f", "f", "h", "f", "f", "e"],
            ["e", "r", "r", "g", "m", "m", "m", "m", "m", "m", "m", "f", "f", "f", "g", "g", "f", "f", "f", "f", "f", "f", "e"],
            ["e", "g", "g", "g", "g", "f", "m", "M", "m", "m", "f", "f", "g", "g", "g", "g", "g", "f", "f", "f", "f", "f", "e"],
            ["e", "m", "f", "f", "f", "f", "M", "M", "m", "f", "f", "g", "g", "g", "g", "g", "g", "g", "f", "f", "f", "f", "e"],
            ["e", "m", "f", "f", "M", "M", "M", "f", "f", "f", "g", "g", "r", "g", "g", "g", "g", "g", "g", "g", "f", "f", "e"],
            ["e", "m", "m", "f", "M", "w", "f", "f", "f", "g", "g", "g", "r", "r", "r", "g", "g", "g", "g", "f", "f", "f", "e"],
            ["e", "m", "m", "M", "M", "w", "w", "f", "f", "g", "g", "g", "g", "g", "r", "g", "g", "f", "f", "f", "f", "f", "e"],
            ["e", "m", "m", "m", "m", "g", "w", "w", "w", "g", "g", "g", "g", "g", "r", "r", "g", "f", "f", "f", "f", "f", "e"],
            ["e", "m", "m", "m", "m", "m", "g", "g", "w", "g", "g", "g", "g", "g", "g", "r", "g", "f", "f", "f", "f", "f", "e"],
            ["e", "m", "m", "m", "f", "f", "g", "r", "W", "r", "g", "g", "g", "g", "g", "r", "r", "r", "f", "f", "f", "f", "e"],
            ["e", "m", "m", "m", "m", "f", "f", "g", "w", "g", "g", "g", "g", "g", "g", "f", "f", "r", "f", "f", "f", "f", "e"],
            ["e", "m", "m", "m", "m", "f", "f", "g", "w", "g", "g", "g", "g", "g", "g", "f", "f", "r", "f", "f", "f", "f", "e"],
            ["e", "e", "e", "e", "e", "e", "e", "e", "e", "e", "e", "e", "e", "e", "e", "e", "e", "R", "e", "e", "e", "e", "e"]
        ],
        map_name: "Zone 2",
        start_position: [1,1],
        map_gateways: {
            '17_15' => {
                zone: 1,
                entry_coords: [17,1]
            }
        }
    }

    MAP_3 = {
        tiles: [
            ["f", "f", "f", "f"],
            ["f", "f", "f", "f"],
            ["f", "f", "f", "f"],
            ["f", "f", "f", "f"]
        ],
        map_name: "Zone 3",
        start_position: [2,2],
        map_gateways: {}
    }

    MAP_4 = {
        tiles: [
            ["m", "m", "m", "m"],
            ["m", "m", "m", "m"],
            ["m", "m", "m", "m"],
            ["m", "m", "m", "m"]
        ],
        map_name: "Zone 4",
        start_position: [3,3],
        map_gateways: {}
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

    def self.generate_new_map(zone)
        map_template = case zone
            when 1
                MAP_1

            when 2
                MAP_2

            when 3
                MAP_3

            when 4
                MAP_4

            else
                MAP_1
            end

        tiles = self.generate_map_tiles(map_template[:tiles])
        map_name = map_template[:map_name]
        start_position = map_template[:start_position]
        map_gateways = map_template[:map_gateways]
        Map.new(map_name, tiles, start_position, map_gateways)
    end
end