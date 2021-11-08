require 'item/armor'
require 'item/potion'
require 'item/shield'
require 'item/weapon'
require 'item/loot_table'
require 'item/item_table'

class ItemGenerator 

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

    def self.create_item_from_key(item_key)
        item_table = ItemTable.new
        item_detail = item_table.get_item_info_by_key(item_key)
        type = item_detail[:type]
        name = item_detail[:name]
        gold = item_detail[:gold_value]
        self.create_item(type, name, gold, item_detail)
    end 

    def self.create_random_item
        loot_table = LootTable.new
        item_key = loot_table.get_random_item 
        self.create_item_from_key(item_key)
    end 
end 