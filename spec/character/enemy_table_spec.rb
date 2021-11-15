require 'character/enemy_table'

describe EnemyTable do 

    it "loads all preconfigured enemies from json file on creation" do
        enemy_table = EnemyTable.new 
        expect( enemy_table.enemies.class ).to eq Hash
        expect( enemy_table.enemies.size ).to eq 18
    end 

    it "can return the info needed to create an enemy based on the enemy key value" do 
        enemy_table = EnemyTable.new 

        wolf_hash = {name: "Wolf", health: 30, strength: 3, defense: 2, level: 1}
        grizzly_hash = {name: "Grizzly Bear", health: 40, strength: 5, defense: 5, level: 1}
        hawk_hash = {name: "Hawk", health: 60, strength: 7, defense: 3, level: 2}

        expect( enemy_table.get_enemy_info_by_key(:wolf) ).to eq wolf_hash
        expect( enemy_table.get_enemy_info_by_key(:grizzly_bear) ).to eq grizzly_hash
        expect( enemy_table.get_enemy_info_by_key(:hawk) ).to eq hawk_hash
    end

    it "returns nil if an invalid enemy key is requested" do 
        enemy_table = EnemyTable.new 
        expect( enemy_table.get_enemy_info_by_key(:not_a_real_enemy) ).to eq nil
    end
end