$LOAD_PATH << './lib'

require 'helpers/utilities'
require 'ui/animations'
require 'action_handler'
require 'game'
require 'game_log'

Animations.title_sequence()
press_any_key_to_continue()

game = Game.new 
ah = ActionHandler.new(game)

while (game.player.is_alive? && game.game_over == false)
    ah.handle_action()
    game.game_sequence()
    ah.get_next_action()
end

system "clear"
Animations.game_over()
press_any_key_to_continue()
system "clear"


