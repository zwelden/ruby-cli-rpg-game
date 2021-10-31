require "./hero.rb"
require "./game_map.rb"
require "./tile.rb"
require "./action_handler.rb"
require "./battle.rb"
require "./map_templates.rb"

ah = ActionHandler.new
tiles = MapTemplates.generate_map_tiles(1)
game_map = GameMap.new(tiles)
hero = Hero.new('Pequad')

action = ""
while (ah.handle_action(action, hero, game_map) && hero.is_alive?)
    has_monsters = ah.check_for_battle(hero, game_map)
    if has_monsters
        Battle.new(hero, game_map)
        if (hero.is_alive? == false)
            break
        end 
    end 
    system "clear"
    puts game_map.render_map(hero)
    puts "#{hero.name} \n- Health: #{hero.health} \n- Strength: #{hero.strength} \n- Defense: #{hero.defense}\n\n"
    puts "Enter next action"
    
    action = ah.get_next_action 
end

system "clear"
puts <<~END 
    \n\n\n\n\n
    \u0020\u0020\u0020╔═══════════╗
    \u0020\u0020\u0020║ Game Over ║
    \u0020\u0020\u0020╚═══════════╝
    \n\n\n\n\n
END


