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
while ah.handle_action(action, hero, game_map)
    has_monsters = ah.check_for_battle(hero, game_map)
    if has_monsters
        Battle.new(hero, game_map)
    end 
    system "clear"
    puts game_map.render_map(hero)
    action = ah.get_next_action 
end




