require "helpers/string_colorize"

class Tile 
    attr_reader :type
    attr_reader :display 
    attr_reader :enemies
    attr_reader :passible
    attr_reader :enemy_chance
    
    def initialize(tile_type, enemies=[])
        @type = tile_type 
        @display = determine_display(tile_type)
        @enemies = enemies
        @passible = determine_passibility(tile_type)
        @enemy_chance = determine_enemy_chance(tile_type)
    end 

    def to_s
        "<Tile type=#{type}>"
    end

    def inspect 
        "<Tile type=#{type}>"
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

        def determine_enemy_chance(tile_type)  
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

            when "enemy"
                ["#?#",
                 "?#?"]

            else 
                ["\u2591\u2591\u2591",
                 "\u2591\u2591\u2591"]
            end
        end 

end
        