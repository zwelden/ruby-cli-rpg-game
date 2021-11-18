require 'item/armor'
require 'item/potion'
require 'item/shield'
require 'item/weapon'
require 'item/loot_table'
require 'item/item_table'

# Class for creating item objects either from a table key value or by a random mechanism
class ItemGenerator 

    # Creates an defined item sub class based on type. 
    # Currently supported item sub classes are 
    # Armor, Potion, Sheild, and Weapon 
    # 
    # @param [string] type - type of item to create 
    # @param [string] name - Name of item 
    # @param [int] gold_value 
    # @param [hash] stats - see sub item class for require stat params
    # @return [<Item>|nil]
    def self.create_item(type, name, gold_value, stats)
        case type
        when "armor" 
            Armor.new(name, gold_value, stats)
        
        when "potion"
            Potion.new(name, gold_value, stats)

        when "shield"
            Shield.new(name, gold_value, stats)

        when "weapon"
            Weapon.new(name, gold_value, stats)
            
        else
            nil
        end
    end 

    # Create an item by ItemTable key value 
    # pulles item details and passes to create_item() 
    #
    # @param [symbol] item_key 
    # @return [<Item>|nil]
    def self.create_item_from_key(item_key)
        item_table = ItemTable.new
        item_detail = item_table.get_item_info_by_key(item_key)
        type = item_detail[:type]
        name = item_detail[:name]
        gold = item_detail[:gold_value]
        self.create_item(type, name, gold, item_detail)
    end 

    # Create a random item from the generic_loot_table.json file 
    #
    # @return [<Item>|nil]
    def self.create_random_item
        loot_table = LootTable.new
        item_key = loot_table.get_random_item 
        self.create_item_from_key(item_key)
    end 

    # Create a random item for a given level of enemy 
    #
    # @param [int] enemy_level
    # @return [<Item>|nil]
    def self.create_random_item_by_enemy_level(enemy_level)
        loot_table = LootTable.new(enemy_level)
        item_key = loot_table.get_random_item 
        self.create_item_from_key(item_key)
    end 
end 