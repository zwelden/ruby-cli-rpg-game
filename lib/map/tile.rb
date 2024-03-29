require "helpers/string_colorize"

# Represents a single x,y coordinate on a map
class Tile 
    attr_reader :type
    attr_reader :display 
    attr_reader :enemies
    attr_reader :passible
    attr_reader :enemy_chance
    attr_reader :treasure_chance
    attr_reader :treasure
    
    # Init 
    #
    # @param [string] tile_type - what type of tile to create - see `determine_display()` for options
    # @param [array[<Enemy>]] enemies - optional preloaded array of enemy objects 
    # @param [hash] treasure - option has of treasue gold and items that can be found
    def initialize(tile_type, enemies=[], treasure={})
        @type = tile_type 
        @display = determine_display(tile_type)
        @enemies = enemies
        @passible = determine_passibility(tile_type)
        @enemy_chance = determine_enemy_chance(tile_type)
        @treasure_chance = determine_treasure_chance(tile_type)
        @treasure = treasure
    end 

    # to_s override
    def to_s
        "<Tile type=#{type}>"
    end

    # inspect override
    def inspect 
        "<Tile type=#{type}>"
    end

    # Convert the tile type to a symbol for key access in various external hashes
    #
    # @return [symbol]
    def type_to_symbol 
        return @type.to_sym
    end

    # Add enemies to tile 
    #
    # @param [array[<Enemy>]]
    def load_enemies(enemies)
        @enemies = enemies
    end 

    # Determine if tile has enemies on it 
    #
    # @return [boolean]
    def has_enemies? 
        @enemies.length > 0
    end

    # Clear all enemies from tile 
    def defeat_enemies 
        @enemies = []
    end

    # Load treasure onto the tile 
    # 
    # @param [int] gold - gold amount to add 
    # @param [array[<Item>]] items 
    def load_treasure(gold, items)
        if (gold > 0)
            @treasure[:gold] = gold 
        end 
        
        if (items.length > 0)
            @treasure[:items] = items 
        end 
    end 

    # Determine if tile has treasure on it 
    #
    # @return [boolean]
    def has_treasure? 
        return (@treasure.key?(:gold) && @treasure[:gold] > 0) ||  (@treasure.key?(:items) && @treasure[:items].length > 0)
    end 

    # Take all treasure from tile 
    #
    # @return [hash] {gold: [int], items: [array[<Item>]]}
    def loot_treasure
        gold = (@treasure.key?(:gold) && @treasure[:gold] > 0) ? @treasure[:gold] : 0
        items = (@treasure.key?(:items) && @treasure[:items].length > 0) ? @treasure[:items] : [] 
    
        @treasure = {}

        {gold: gold, items: items}
    end 

    # Determine if tile is a path to a new map 
    #
    # @return [boolean]
    def is_path_to_new_map? 
        self.type == "R"
    end 

    # Determine if tile has a shop on it
    #
    # @return [boolean]
    def is_shop?
        self.type == "s"
    end 

    private
        # Determin if type type is able to be moved into 
        #
        # @return [boolean]
        def determine_passibility(tile_type)
            case tile_type
            when "w"
                false

            when "x"
                false

            when "M"
                false

            when "e"
                false

            else
                true
            end    
        end 

        # Determine probability of finding an ememy on tile by tile type 
        # 
        # @return [int]
        def determine_enemy_chance(tile_type)  
            case tile_type
            when "g"
                5

            when "m"
                25

            when "f"
                15

            when "t"
                50

            when "T"
                50

            else  
                0
            end
        end 

        # Determine probabiliy of finding treasure on tile by tile type 
        #
        # @return [int]
        def determine_treasure_chance(tile_type)
            case tile_type
            when "g"
                1

            when "m"
                5

            when "f"
                3

            when "t"
                10

            when "T"
                10

            when "c"
                100

            else  
                0
            end
        end 

        # Determine the display strings used for a given tile type 
        # Note tile width is 4 chars and height is 2 chars
        #
        # @return [array[<String>]]
        def determine_display(tile_type)
            case tile_type
            when "player"
                ["(oo)".colorize("white").colorize("bold").colorize("bg_blue"),
                 "═╬═!".colorize("white").colorize("bold").colorize("bg_blue")]\

            when "r"
                ["░▒░▒".colorize("bright_yellow").colorize("bg_black"),
                 "▒░▒░".colorize("bright_yellow").colorize("bg_black")] 
            
            when "R"
                tile_a = "░".colorize("bright_red")
                tile_b = "▒".colorize("bright_yellow")
                ["#{tile_a}#{tile_b}#{tile_a}#{tile_b}".colorize("bg_black"),
                 "#{tile_b}#{tile_a}#{tile_b}#{tile_a}".colorize("bg_black")] 

            when "e"
                ["    ".colorize("bright_black"),
                 "    ".colorize("bright_black")] 

            when "g"
                 ["\u2591\u2591\u2591\u2591",
                  "\u2591\u2591\u2591\u2591"]

            when "w"
                ["~≈~ ".colorize("bright_cyan").colorize("bg_blue"),
                 " ≈~≈".colorize("bright_cyan").colorize("bg_blue")]

            when "b"
                ["╤╤╤╤".colorize("bright_yellow").colorize("bg_blue"),
                 "╧╧╧╧".colorize("bright_yellow").colorize("bg_blue")]

            when "B"
                ["╟──╢".colorize("bright_yellow").colorize("bg_blue"),
                 "╟──╢".colorize("bright_yellow").colorize("bg_blue")]

            when "x"
                ["\u2588\u2588\u2588\u2588".colorize("bright_black"),
                 "\u2588\u2588\u2588\u2588".colorize("bright_black")]

            when "f"
                ["\u2663\u2663\u2663\u2663".colorize("green"),
                 "\u2663\u2663\u2663\u2663".colorize("green")]

            when "t"
                [" ╬ ✝".colorize("bright_black"),
                 "✝ ╬ ".colorize("bright_black")]

            when "T"
                [" ✝. ",
                 " [] "]
            
            when "y" 
                [" .  ".colorize("bright_black"),
                 ".  .".colorize("bright_black")] 

            when "Y"
                ["__✝_".colorize("red"),
                 "│__│".colorize("red")]

            when "c"
                ["¿‼$?".colorize("red").colorize("bg_yellow"),
                 "♦£¥$".colorize("red").colorize("bg_yellow")]

            when "h"
                ["/^^\\",
                 "|__|"]

            when "s"
                ["/^^\\",
                 "|$$|"]

            when "m"
                ["A^A^".colorize("bright_black"),
                 "^A^A".colorize("bright_black")]
                
            when "M" 
                ["\u26F0\u26F0\u26F0\u26F0".colorize("bright_black"),
                 "\u26F0\u26F0\u26F0\u26F0".colorize("bright_black")]

            else 
                ["\u2591\u2591\u2591\u2591",
                 "\u2591\u2591\u2591\u2591"]
            end
        end 

end
        