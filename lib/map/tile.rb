require "helpers/string_colorize"

class Tile 
    attr_reader :type
    attr_reader :display 
    attr_reader :enemies
    attr_reader :passible
    attr_reader :enemy_chance
    attr_reader :treasure_chance
    attr_reader :treasure
    
    def initialize(tile_type, enemies=[], treasure={})
        @type = tile_type 
        @display = determine_display(tile_type)
        @enemies = enemies
        @passible = determine_passibility(tile_type)
        @enemy_chance = determine_enemy_chance(tile_type)
        @treasure_chance = determine_treasure_chance(tile_type)
        @treasure = treasure
    end 

    def to_s
        "<Tile type=#{type}>"
    end

    def inspect 
        "<Tile type=#{type}>"
    end

    def type_to_symbol 
        return @type.to_sym
    end

    def load_enemies(enemies)
        @enemies = enemies
    end 

    def has_enemies? 
        @enemies.length > 0
    end

    def defeat_enemies 
        @enemies = []
    end

    def load_treasure(gold, items)
        if (gold > 0)
            @treasure[:gold] = gold 
        end 
        
        if (items.length > 0)
            @treasure[:items] = items 
        end 
    end 

    def has_treasure? 
        return (@treasure.key?(:gold) && @treasure[:gold] > 0) ||  (@treasure.key?(:items) && @treasure[:items].length > 0)
    end 

    def loot_treasure
        gold = (@treasure.key?(:gold) && @treasure[:gold] > 0) ? @treasure[:gold] : 0
        items = (@treasure.key?(:items) && @treasure[:items].length > 0) ? @treasure[:items] : [] 
    
        @treasure = {}

        {gold: gold, items: items}
    end 

    def is_path_to_new_map? 
        self.type == "R"
    end 

    def is_shop?
        self.type == "s"
    end 

    private
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
        