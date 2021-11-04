require 'items/armor'
require 'items/potion'
require 'items/shield'
require 'items/weapon'
require 'items/loot_table'

class ItemGenerator 

    def self.create_item(type, name, stats)
        case type
        when :armor 
            Armor.new(name, stats)
        
        when :potion 
            Potion.new(name, stats)

        when :shield 
            Shield.new(name, stats)

        when :weapon 
            Weapon.new(name, stats)
            
        else
            nil
        end
    end 

    def self.create_random_item
        item_detail = LootTable.get_random_item 
        type = item_detail[:type]
        name = item_detail[:name]
        self.create_item(type, name, item_detail)
    end 
end 