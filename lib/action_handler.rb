require 'ui/display'

class ActionHandler
    def get_next_action(prompt='> ')
        puts "Enter next action. 'help' for options."
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
        
        when "help"
            system "clear"
            Display.action_options
            true 

        else 
            true
        end 
    end 
end 
        