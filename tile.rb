require "./string_colorize.rb"

class Tile 
    attr_reader :type
    attr_reader :display 
    attr_reader :monsters
    attr_reader :passible
    attr_reader :monster_chance
    
    def initialize(tile_type, monsters=[])
        @type = tile_type 
        @display = determine_display(tile_type)
        @monsters = monsters
        @passible = determine_passibility(tile_type)
        @monster_chance = determine_monster_chance(tile_type)
    end 

    def to_s
        "<Tile type=#{type}>"
    end

    def inspect 
        "<Tile type=#{type}>"
    end

    def load_monsters(monsters)
        @monsters = monsters
    end 

    def has_monsters? 
        @monsters.length > 0
    end

    def defeat_monsters 
        @monsters = []
    end

    private
        def determine_passibility(tile_type)
            case tile_type
            when "w"
                false

            when "x"
                false

            else
                true
            end    
        end 

        def determine_monster_chance(tile_type)  
            case tile_type
            when "g"
                1
            when "m"
                10
            when "f"
                5
            else  
                0
            end
        end 

        def determine_display(tile_type)
            case tile_type
            when "hero"
                ["^X^".colorize("black").colorize("bg_white"),
                 "X^X".colorize("black").colorize("bg_white")]

            when "g"
                 ["\u2591\u2591\u2591",
                  "\u2591\u2591\u2591"]

            when "w"
                ["~≈~".colorize("cyan"),
                 "≈~≈".colorize("cyan")]

            when "x"
                ["\u2588\u2588\u2588".colorize("bright_black"),
                 "\u2588\u2588\u2588".colorize("bright_black")]

            when "f"
                ["\u2663\u2663\u2663".colorize("green"),
                 "\u2663\u2663\u2663".colorize("green")]

            when "h"
                ["/^\\",
                 "|_|"]

            when "m"
                ["A^A".colorize("bright_black"),
                 "^A^".colorize("bright_black")]

            when "monster"
                ["#?#",
                 "?#?"]

            else 
                ["\u2591\u2591\u2591",
                 "\u2591\u2591\u2591"]
            end
        end 

end
        