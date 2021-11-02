require "./player.rb"
require "./map.rb"
require "./tile.rb"
require "./action_handler.rb"
require "./battle.rb"
require "./map_templates.rb"
require "./animations.rb"
require "./utilities.rb"
require "./game.rb"

game = Game.new 

Animations.title_sequence
press_any_key_to_continue()

ah = ActionHandler.new
tiles = MapTemplates.generate_map_tiles(1)
map = Map.new(tiles)
player = Player.new('Pequad')

action = ""
while (ah.handle_action(action, player, map) && player.is_alive?)
    has_monsters = game.check_for_battle(player, map)
    if has_monsters
        Animations.battle
        press_any_key_to_continue()
        Battle.new(player, map)
        if (player.is_alive? == false)
            break
        end 
    end 
    system "clear"
    puts map.render_map(player)
    puts "#{player.name} \n- Health: #{player.health} \n- Strength: #{player.strength} \n- Defense: #{player.defense}\n\n"
    puts "Enter next action"

    action = ah.get_next_action 
end

system "clear"
Animations.game_over 
press_any_key_to_continue()
system "clear"


