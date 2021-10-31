class ActionHandler
    def get_next_action(prompt='> ')
        print prompt
        gets.chomp 
    end 

    def handle_action(action, player, map)
        case action
        when "q"
            false
        when "w"
            player.move_up(map)
            true
        when "s"
            player.move_down(map)
            true
        when "a"
            player.move_left(map)
            true
        when "d"
            player.move_right (map)
            true
        when "sleep"
            player.sleep 
            true
        else 
            true
        end 
    end 

    def check_for_battle(player, map)
        player_x, player_y = player.coords 
        return map.has_monsters?(player_x, player_y)
    end
end 
        