require 'character/enemy_zone_table'

describe EnemyZoneTable do 

    it "creates a tile based weight table on intialization" do
        enemy_zone_table = EnemyZoneTable.new("zone_test")
        expected_weight_table = {
            g: {
                bandit: {
                    weight: 2
                }, 
                rat: {
                    weight: 3
                }
            },
            f: {
                wolf: {
                    weight: 6
                }, 
                spider: { 
                    weight: 5
                }, 
                forest_troll: {
                    weight: 2
                }
            },
            m: {
                grizzly_bear: {
                    weight: 3
                },
                mountain_troll: {
                    weight: 1
                }
            }
        }

        expect( enemy_zone_table.enemy_weight_table ).to eq expected_weight_table
    end 

    it "creates a array of roll values to enemies table on intialization" do
        enemy_zone_table = EnemyZoneTable.new("zone_test")    
        expected_roll_map = {
            f: [:wolf, :wolf, :wolf, :wolf, :wolf, :wolf, :spider, :spider, :spider, :spider, :spider, :forest_troll, :forest_troll],
            g: [:bandit, :bandit, :rat, :rat, :rat],
            m: [:grizzly_bear, :grizzly_bear, :grizzly_bear, :mountain_troll]
        }
        expect( enemy_zone_table.enemy_roll_map ).to eq expected_roll_map
    end 

    it "generates a random enemy key based on passed tile type" do 
        enemy_zone_table = EnemyZoneTable.new("zone_test")    

        srand 100 

        random_enemy_key1 = enemy_zone_table.get_random_enemy_key(:f)
        random_enemy_key2 = enemy_zone_table.get_random_enemy_key(:g)
        random_enemy_key3 = enemy_zone_table.get_random_enemy_key(:m)

        expect( random_enemy_key1 ).to eq :spider
        expect( random_enemy_key2 ).to eq :bandit
        expect( random_enemy_key3 ).to eq :mountain_troll
    end 

    it "returns nil if passed tile type does not exist" do 
        enemy_zone_table = EnemyZoneTable.new("zone_test")    
        enemy_zone_table.get_random_enemy_key(:not_a_real_tile)
        expect( enemy_zone_table.get_random_enemy_key(:not_a_real_tile) ).to eq nil
    end 
end