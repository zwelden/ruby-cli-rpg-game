$LOAD_PATH << './lib'

require "character/player"
require "map/map_generator"
require "helpers/utilities"
require "ui/animations"
require "ui/display"
require "action_handler"
require "battle"
require "game"
require 'game_log'

Animations.title_sequence
press_any_key_to_continue()

game = Game.new 
ah = ActionHandler.new
map = MapGenerator.generate_new_map(1)

player = Player.generate_new_player
player.set_start_position(*map.start_position)

action = ""
while (ah.handle_action(action, player, map) && player.is_alive?)
    has_enemies = game.check_for_battle(player, map)
    if has_enemies
        Animations.battle
        press_any_key_to_continue()
        Battle.new(player, map)
        if (player.is_alive? == false)
            break
        end 
    end 
    system "clear"
    puts map.render_map(player)
    # puts "#{player.name} \n- Health: #{player.health} \n- Strength: #{player.strength} \n- Defense: #{player.defense}\n\n"
    Display.player_info(player)
    
    action = ah.get_next_action 
end

system "clear"
Animations.game_over 
press_any_key_to_continue()
system "clear"


