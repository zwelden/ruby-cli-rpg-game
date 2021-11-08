require 'place/place'
require 'helpers/utilities'
require 'item/shop_table'
require 'item/item_generator'

class Shop < Place
    attr_reader :items_for_sale
    attr_reader :shop_table

    def initialize(name, max_items, type, level)
        super(name, :shop)
        num_items = rand(2..max_items)

        @shop_table = ShopTable.new(type, level)
        
        @items_for_sale = []

        num_items.times do 
            item_key = @shop_table.get_random_item_key()
            item = ItemGenerator.create_item_from_key(item_key)
            @items_for_sale.push(item)
        end
    end 

    def view_place
        puts "Entering Shop"
        @items_for_sale.each do |item|
            buy_price = item.gold_value * 2
            puts "* #{item.name} - $#{buy_price}"
        end 
        press_any_key_to_continue()
    end 

    def sell_item(player, item)
        puts "selling #{item.name}"
    end 

    def buy_item
        puts "buying an item"
    end
end 