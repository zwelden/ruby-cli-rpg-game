require 'place/place'
require 'helpers/utilities'
require 'item/shop_table'
require 'item/item_generator'
require 'ui/display'
require 'securerandom'
require 'inventory_manager'

class Shop < Place
    attr_reader :items_for_sale
    attr_reader :max_items
    attr_reader :shop_table
    attr_reader :symbol_ref
    attr_reader :shop_markup
    attr_reader :player_in_store
    def initialize(name, max_items, type, level)
        super(name, :shop)
        
        hex_value = SecureRandom.hex(5)
        
        @max_items = max_items
        @shop_table = ShopTable.new(type, level)
        @symbol_ref = "shop_#{hex_value}".to_sym
        @shop_markup = 2
        @player_in_store = false

        reload_items_for_sale()
    end 

    def reload_items_for_sale 
        @items_for_sale = []
        num_items = rand(2..@max_items)
        num_items.times do 
            item_key = @shop_table.get_random_item_key()
            item = ItemGenerator.create_item_from_key(item_key)
            add_item_to_inventory(item)
        end
    end

    def add_item_to_inventory(item)
        @items_for_sale.push(item)
    end 

    def index_in_shop_inventory?(index)
        return (@items_for_sale.length > 0 && index >= 0 && index < @items_for_sale.length) 
    end

    def get_item_from_shop_inventory_by_index(index)
        @items_for_sale[index]
    end

    def remove_item_from_shop_inventory_by_index(index)
        @items_for_sale.delete_at(index)
    end
        
    def view_place(player)
        @player_in_store = true
        store_loop(player)
    end 

    def leave_store
        @player_in_store = false
    end

    def sell_item(player)
        puts "Select item to sell."
        print "Item #: "
        item_idx = gets.chomp.to_i - 1
        if (player.index_in_inventory?(item_idx) == false)
            puts "Invalid items selected"
            press_any_key_to_continue()
            return
        end 

        item = player.get_item_at_inventory_index(item_idx)
        gold_value = item.gold_value

        player.add_gold(gold_value)
        add_item_to_inventory(item)
        player.remove_item_from_inventory_at_index(item_idx)
        puts "You sold #{item.name}"
        press_any_key_to_continue()
    end 

    def buy_item(player)
        puts "Select item to buy."
        print "Item #: "
        item_idx = gets.chomp.to_i - 1
        if (index_in_shop_inventory?(item_idx) == false)
            puts "Invalid items selected"
            press_any_key_to_continue()
            return
        end 

        item = get_item_from_shop_inventory_by_index(item_idx)
        gold_cost = item.gold_value * @shop_markup

        if (player.gold < gold_cost)
            puts "Insufient funds"
            press_any_key_to_continue()
            return
        end 

        player.reduce_gold(gold_cost)
        player.add_item_to_inventory(item)
        remove_item_from_shop_inventory_by_index(item_idx)
        puts "You bought #{item.name}"
        press_any_key_to_continue()
    end

    def view_item(player)
        puts "View store item or your item?"
        puts "s - store"
        puts "m - me"
        print "> "
        col_choice = gets.chomp 

        if (col_choice != "s" && col_choice != "m")
            puts "Invalid selection."
            press_any_key_to_continue()
            return
        end 

        puts "Selection item to view."
        print "Item #: "
        item_idx = gets.chomp.to_i - 1

        case col_choice
        when "s"
            if (index_in_shop_inventory?(item_idx) == false)
                puts "Invalid items selected"
                press_any_key_to_continue()
                return
            end 
            item = get_item_from_shop_inventory_by_index(item_idx)

        when "m"
            if (player.index_in_inventory?(item_idx) == false)
                puts "Invalid items selected"
                press_any_key_to_continue()
                return
            end 
            item = player.get_item_at_inventory_index(item_idx)

        end

        Display.show_item_detail(item)
        press_any_key_to_continue()
    end 

    def get_next_store_action 
        puts "What would you like to do? "
        puts "b - buy item"
        puts "s - sell item"
        puts "v - view item"
        puts "c - view character"
        puts "l - leave"
        print "> "
        gets.chomp 
    end 

    def handle_store_action(action, player)
        case action
        when "b"
            buy_item(player)

        when "s"
            sell_item(player)

        when "v"
            view_item(player)

        when "c"
            InventoryManager.manage_inventory(player)

        when "l"
            leave_store()

        end
    end

    def store_loop(player)
        while(@player_in_store) 
            system "clear"
            Display.show_shop(@name, @items_for_sale, @shop_markup, player)
            action = get_next_store_action()
            handle_store_action(action,  player)
        end 
    end 
end 