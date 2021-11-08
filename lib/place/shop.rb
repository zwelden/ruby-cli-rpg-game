require 'place/place'
require 'helpers/utilities'

class Shop < Place
    
    def initialize(name)
        super(name, :shop)
    end 

    def view_place
        puts "Entering Shop"
        press_any_key_to_continue()
    end 

    def sell_item(player, item)
        puts "selling #{item.name}"
    end 

    def buy_item
        puts "buying an item"
    end
end 