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

    def self.create_random_item
        item_table = ItemTable.new
        lt = LootTable.new
        item_key = lt.get_random_item 
        item_detail = item_table.get_item_info_by_key(item_key)
        type = item_detail[:type]
        name = item_detail[:name]
        gold = item_detail[:gold_value]
        self.create_item(type, name, gold, item_detail)
    end 
end 