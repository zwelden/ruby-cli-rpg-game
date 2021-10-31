require "./tile.rb"
require "./monster.rb"

class MapTemplates 

    MAP_1 = [
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
    ]

    MAP_2 = [
        ["g", "g", "g", "g"],
        ["g", "g", "g", "g"],
        ["g", "g", "g", "g"],
        ["g", "g", "g", "g"]
    ]

    def self.generate_map_tiles(map_level)
        map_template = case map_level
            when 1
                MAP_1
            when 2
                MAP_2
            else
                
            end

        monsters = [["Bandit", 10, 2, 2], ["Goul", 10, 1, 1], ["Rat", 5, 5, 1], ["Skeleton", 10, 5, 1], ["Zombie", 20, 3, 2]]
        
        tiles = []

        map_template.each do |row|
            tile_row = []
            row.each do |tile_type|
                
                monster_arr = []
        
                if rand(10) == 0
                    monster_count = rand(1..3)
                    monster_count.times do
                        monster_info = monsters.sample
                        monster_arr.push(Monster.new(*monster_info))
                    end 
                end 
        
                tile_row.push(Tile.new(tile_type, monster_arr))
            end 
            tiles.push(tile_row)
        end 

        tiles
    end
end