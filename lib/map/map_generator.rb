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
            ["e", "m", "g", "g", "g", "g", "g", "g", "g", "g", "g", "r", "x", "g", "s", "g", "x", "g", "g", "g", "f", "f", "e"],
            ["e", "m", "m", "g", "g", "g", "g", "g", "g", "g", "g", "r", "x", "x", "x", "x", "x", "g", "g", "f", "f", "f", "e"],
            ["e", "m", "m", "m", "g", "g", "g", "g", "g", "g", "g", "r", "g", "g", "g", "g", "g", "f", "f", "f", "f", "f", "e"],
            ["e", "m", "m", "m", "g", "g", "g", "w", "w", "w", "r", "r", "g", "g", "g", "g", "g", "f", "f", "f", "f", "f", "e"],
            ["e", "m", "m", "g", "g", "g", "w", "w", "w", "w", "r", "g", "g", "g", "g", "g", "g", "g", "f", "f", "f", "f", "e"],
            ["e", "m", "g", "g", "g", "g", "g", "g", "g", "r", "r", "g", "g", "g", "g", "g", "g", "g", "g", "g", "f", "g", "e"],
            ["e", "m", "m", "g", "g", "g", "g", "g", "g", "r", "g", "g", "g", "g", "g", "g", "g", "g", "g", "f", "f", "g", "e"],
            ["e", "m", "m", "g", "g", "g", "g", "g", "g", "r", "g", "g", "g", "g", "g", "g", "g", "g", "g", "g", "g", "g", "e"],
            ["e", "e", "e", "e", "e", "e", "e", "e", "e", "R", "e", "e", "e", "e", "e", "e", "e", "e", "e", "e", "e", "e", "e"]
        ],
        map_name: "Pleasant Meadow",
        zone_id: :zone_1,
        start_position: [14,4],
        map_gateways: {
            '0_2' => {
                zone: 3,
                entry_coords: [21,2]
            },
            '17_0' => {
                zone: 2,
                entry_coords: [17,14]
            },
            '9_15' => {
                zone: 4,
                entry_coords: [9,1]
            }
        },
        places: {
            '14_7' => {
                place_type: :shop,
                name: "Bob's Bait and Tackle Shop",
                max_items: 5,
                type: "generic",
                level: 1
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
            ["e", "m", "m", "m", "f", "f", "g", "r", "b", "r", "g", "g", "g", "g", "g", "r", "r", "r", "f", "f", "f", "f", "e"],
            ["e", "m", "m", "m", "m", "f", "f", "g", "w", "g", "g", "g", "g", "g", "g", "f", "f", "r", "f", "f", "f", "f", "e"],
            ["e", "m", "m", "m", "m", "f", "f", "g", "w", "g", "g", "g", "g", "g", "g", "f", "f", "r", "f", "f", "f", "f", "e"],
            ["e", "e", "e", "e", "e", "e", "e", "e", "e", "e", "e", "e", "e", "e", "e", "e", "e", "R", "e", "e", "e", "e", "e"]
        ],
        map_name: "Mountain Pass",
        zone_id: :zone_2,
        start_position: [1,1],
        map_gateways: {
            '17_15' => {
                zone: 1,
                entry_coords: [17,1]
            }
        },
        places: {}
    }

    MAP_3 = {
        tiles: [
            ["e", "e", "e", "e", "e", "e", "e", "e", "e", "e", "e", "e", "e", "e", "e", "e", "e", "e", "e", "e", "e", "e", "e"],
            ["e", "m", "m", "m", "m", "m", "m", "f", "f", "f", "f", "f", "f", "f", "f", "f", "f", "f", "f", "f", "g", "g", "e"],
            ["e", "m", "m", "f", "f", "f", "f", "f", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "f", "g", "g", "r", "R"],
            ["e", "m", "f", "f", "f", "f", "f", "f", "x", "T", "t", "t", "t", "y", "t", "t", "t", "x", "g", "g", "r", "r", "e"],
            ["e", "m", "f", "f", "f", "x", "x", "x", "x", "t", "t", "T", "t", "t", "g", "t", "t", "x", "g", "g", "r", "g", "e"],
            ["e", "m", "f", "f", "f", "x", "t", "T", "t", "g", "t", "t", "t", "t", "t", "t", "t", "x", "r", "r", "r", "g", "e"],
            ["e", "m", "m", "f", "x", "x", "t", "y", "t", "t", "y", "x", "t", "T", "t", "r", "r", "r", "r", "g", "g", "g", "e"],
            ["e", "m", "m", "f", "x", "c", "t", "g", "T", "t", "t", "x", "t", "t", "t", "t", "t", "x", "g", "g", "g", "m", "e"],
            ["e", "m", "m", "f", "x", "x", "t", "t", "t", "t", "t", "x", "T", "t", "t", "T", "t", "x", "g", "g", "m", "m", "e"],
            ["e", "m", "f", "f", "f", "x", "t", "t", "t", "y", "t", "t", "t", "t", "y", "t", "g", "x", "g", "g", "m", "m", "e"],
            ["e", "m", "f", "f", "f", "x", "x", "x", "x", "t", "T", "t", "g", "t", "t", "t", "t", "x", "g", "g", "m", "m", "e"],
            ["e", "m", "f", "f", "f", "f", "f", "f", "x", "t", "t", "t", "t", "T", "t", "Y", "t", "x", "g", "g", "m", "m", "e"],
            ["e", "m", "f", "f", "f", "f", "f", "f", "x", "t", "t", "t", "t", "t", "t", "t", "t", "x", "g", "g", "m", "m", "e"],
            ["e", "m", "m", "f", "f", "f", "f", "f", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "f", "m", "m", "m", "e"],
            ["e", "m", "m", "m", "m", "m", "m", "f", "f", "f", "f", "f", "f", "f", "f", "f", "f", "f", "f", "m", "m", "m", "e"],
            ["e", "e", "e", "e", "e", "e", "e", "e", "e", "e", "e", "e", "e", "e", "e", "e", "e", "e", "e", "e", "e", "e", "e"]
        ],
        map_name: "Graveyard",
        zone_id: :zone_3,
        start_position: [2,2],
        map_gateways: {
            '22_2' => {
                zone: 1,
                entry_coords: [1,2]
            }
        },
        places: {}
    }

    MAP_4 = {
        tiles: [
            ["e", "e", "e", "e", "e", "e", "e", "e", "e", "R", "e", "e", "e", "e", "e", "e", "e", "e", "e", "e", "e", "e", "e"],
            ["e", "m", "m", "f", "f", "f", "g", "g", "g", "r", "r", "r", "g", "g", "g", "g", "f", "f", "f", "m", "m", "m", "e"],
            ["e", "m", "f", "f", "g", "g", "g", "g", "x", "x", "x", "r", "x", "x", "g", "g", "g", "f", "f", "f", "m", "m", "e"],
            ["e", "f", "f", "g", "g", "x", "x", "x", "x", "x", "h", "r", "h", "x", "x", "x", "x", "g", "g", "f", "f", "m", "e"],
            ["e", "f", "g", "g", "x", "x", "h", "h", "r", "h", "h", "r", "h", "h", "r", "h", "x", "x", "g", "g", "f", "w", "e"],
            ["e", "f", "g", "x", "x", "r", "r", "r", "r", "r", "r", "r", "r", "r", "r", "r", "r", "x", "x", "w", "w", "w", "e"],
            ["e", "f", "g", "x", "h", "r", "h", "h", "r", "h", "s", "r", "h", "h", "r", "h", "r", "r", "x", "w", "f", "f", "e"],
            ["e", "f", "r", "r", "r", "r", "s", "h", "r", "h", "h", "r", "h", "h", "r", "h", "h", "r", "r", "b", "f", "f", "e"],
            ["e", "f", "g", "x", "h", "w", "w", "w", "B", "w", "w", "B", "w", "w", "B", "w", "w", "w", "w", "w", "f", "f", "e"],
            ["e", "f", "g", "x", "x", "w", "x", "h", "r", "h", "h", "r", "h", "h", "r", "h", "h", "x", "x", "g", "f", "f", "e"],
            ["e", "f", "g", "g", "x", "w", "x", "h", "r", "h", "h", "r", "s", "r", "r", "h", "x", "x", "g", "g", "f", "f", "e"],
            ["e", "w", "w", "w", "w", "w", "x", "x", "r", "r", "r", "r", "r", "r", "x", "x", "x", "g", "g", "f", "f", "f", "e"],
            ["e", "f", "f", "f", "g", "w", "w", "x", "x", "x", "x", "r", "x", "x", "x", "g", "g", "g", "f", "f", "f", "m", "e"],
            ["e", "m", "f", "f", "f", "f", "w", "g", "g", "g", "g", "r", "g", "g", "g", "g", "g", "f", "f", "f", "m", "m", "e"],
            ["e", "m", "m", "f", "f", "f", "w", "f", "f", "f", "f", "f", "f", "f", "f", "f", "f", "f", "f", "m", "m", "m", "e"],
            ["e", "e", "e", "e", "e", "e", "e", "e", "e", "e", "e", "e", "e", "e", "e", "e", "e", "e", "e", "e", "e", "e", "e"]
        ],
        map_name: "Big City",
        zone_id: :zone_4,
        start_position: [3,3],
        map_gateways: {
            '9_0' => {
                zone: 1,
                entry_coords: [9,14]
            }
        },
        places: {
            '10_6' => {
                place_type: :shop,
                name: "Dave's Weapon Outlet",
                max_items: 4,
                type: "weapon",
                level: 1
            },
            '6_7' => {
                place_type: :shop,
                name: "Franks's Armor Depot",
                max_items: 4,
                type: "armor",
                level: 1
            },
            '12_10' => {
                place_type: :shop,
                name: "Tims's General Goods Store",
                max_items: 5,
                type: "generic",
                level: 2
            }
        }
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
        map_zone_id = map_template[:zone_id]
        start_position = map_template[:start_position]
        map_gateways = map_template[:map_gateways]
        places = map_template[:places]
        Map.new(map_name, map_zone_id, tiles, start_position, map_gateways, places)
    end
end