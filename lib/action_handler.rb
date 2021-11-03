require 'io/console'
require 'ui/display'

class ActionHandler
    def get_next_action(prompt='> ')
        STDIN.iflush()
        puts "Enter next action. 'help' for options."
        print prompt
        gets.chomp 
    end 

    def handle_action(action, player, map)
        case action
        when "q"
            false

        when "w"
            player.move(map, :up)
            true

        when "s"
            player.move(map, :down)
            true

        when "a"
            player.move(map, :left)
            true

        when "d"
            player.move(map, :right)
            true

        when "i"
            player.show_inventory()
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
        