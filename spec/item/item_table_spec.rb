require 'item/item_table'

describe ItemTable do 

    it "loads all preconfigured items from json file on creation" do
        item_table = ItemTable.new 
        expect( item_table.items.class ).to eq Hash
        expect( item_table.items.size ).to eq 26
    end 

    it "can return the info needed to create an item based on the item key value" do 
        item_table = ItemTable.new 

        staff_1_hash = {name: "Staff", type: "weapon", power: 3, gold_value: 6}
        body_armor_3_hash = {name: "Studded Leather Armor", type: "armor", armor: 4, armor_type: "body", gold_value: 15}
        shield_2_hash = {name: "Wood Shield", type: "shield", armor: 2, gold_value: 10}

        expect( item_table.get_item_info_by_key(:staff_1) ).to eq staff_1_hash
        expect( item_table.get_item_info_by_key(:body_armor_3) ).to eq body_armor_3_hash
        expect( item_table.get_item_info_by_key(:shield_2) ).to eq shield_2_hash
    end

    it "returns nil if an invalid item key is requested" do 
        item_table = ItemTable.new 
        expect( item_table.get_item_info_by_key(:not_a_real_item) ).to eq nil
    end
end