require 'io/console'
require 'ui/display'
require 'inventory_manager'
require 'helpers/utilities'

class ActionHandler
    attr_reader :action 

    def initialize(game)
        @game = game 
        @action = ""
    end 

    def get_next_action(prompt='> ')
        return if @game.game_over 

        STDIN.iflush()
        puts "Enter next action. 'help' for options."
        print prompt
        @action = gets.chomp 
    end 

    def handle_action()
        return if @game.game_over 

        case @action
        when "q"
            @game.end_game()

        when "w"
            @game.player.move(@game.map, :up)
            @game.increase_turn_count()

        when "s"
            @game.player.move(@game.map, :down)
            @game.increase_turn_count()

        when "a"
            @game.player.move(@game.map, :left)
            @game.increase_turn_count()

        when "d"
            @game.player.move(@game.map, :right)
            @game.increase_turn_count()

        when "i"
            @game.player.show_inventory()

        when "c"
            InventoryManager.manage_inventory(@game.player)

        when "sleep"
            sleep_cooldown = @game.get_cooldown(:player_sleep)
            if (sleep_cooldown == nil || sleep_cooldown[:turns] <= 0)
                @game.player.sleep()
                @game.increase_turn_count()
                @game.add_cooldown(:player_sleep, 3)
            else 
                puts "You have recently slept, you need to move around a bit before you can sleep again"
                press_any_key_to_continue()
            end 
        
        when "help"
            system "clear"
            Display.action_options

        end
        
        @action = ""
    end 
end 
        