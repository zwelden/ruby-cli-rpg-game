# NOTE: copy edit_template.txt to edit.txt to use

$LOAD_PATH << File.expand_path(File.dirname(File.dirname(File.dirname(__FILE__))))

require 'map/map_generator'
require 'map/map'


def get_new_tile_array
    file = File.expand_path(File.dirname(__FILE__)) + '/edit.txt'
    contents = File.open(file) {|f| f.read }
    eval contents

end 

def update_map()
    tile_arr = get_new_tile_array 
    tiles = MapGenerator.generate_map_tiles(tile_arr)

    map_name = 'Test Map'
    start_position = [0,0]
    map_gateways = {}
    map_places = {}
    Map.new(map_name, :zone_1, tiles, start_position, map_gateways, map_places)
end 

while true 
    system "clear"
    map = update_map()
    puts map.render_map(nil)
    sleep(3)
end