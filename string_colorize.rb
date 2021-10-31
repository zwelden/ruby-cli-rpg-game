class String
    # colorization
    def colorize(color)
        color_code = "0"

        case color
        when "black"
            color_code = "30"
            
        when "red"
           color_code = "31"

        when "green"
            color_code = "32"
            
        when "yellow"
            color_code = "33"

        when "blue"
            color_code = "34"

        when "magenta"
            color_code = "35"

        when "cyan"
            color_code = "36"
        
        when "white"
            color_code = "37"
        
        when "bright_black"
            color_code = "30;1"

        when "bright_red"
            color_code = "31;1"

        when "bright_green"
            color_code = "32;1"
            
        when "bright_yellow"
            color_code = "33;1"

        when "bright_blue"
            color_code = "34;1"

        when "bright_magenta"
            color_code = "35;1"

        when "bright_cyan"
            color_code = "36;1"

        when "bg_black"
            color_code = "40"

        when "bg_red"
            color_code = "41"

        when "bg_green"
            color_code = "42"

        when "bg_yellow"
            color_code = "43"

        when "bg_blue"
            color_code = "44"

        when "bg_magenta"
            color_code = "45"
        
        when "bg_cyan"
            color_code = "46"

        when "bg_white"
            color_code = "47"

        when "bold"
            color_code = "1"

        when "underline"
            color_code = "4"

        end
        
        "\e[#{color_code}m#{self}\e[0m"
    end
end