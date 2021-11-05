require 'items/armor'
require 'items/potion'
require 'items/shield'
require 'items/weapon'
require 'items/loot_table'

class ItemGenerator 

    def self.create_item(type, name, gold_value, stats)
        case type
        when :armor 
            Armor.new(name, gold_value, stats)
        
        when :potion 
            Potion.new(name, gold_value, stats)

        when :shield 
            Shield.new(name, gold_value, stats)

        when :weapon 
            Weapon.new(name, gold_value, stats)
            
        else
            nil
        end
    end 

    def self.create_random_item
        item_detail = LootTable.get_random_item 
        type = item_detail[:type]
        name = item_detail[:name]
        gold = item_detail[:gold_value]
        self.create_item(type, name, gold, item_detail)
    end 
end 