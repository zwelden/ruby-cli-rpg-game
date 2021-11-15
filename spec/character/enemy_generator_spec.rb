require 'character/enemy_generator'

describe EnemyGenerator do 

    it "creates an enemy table on intialization" do
        enemy_generator = EnemyGenerator.new 
        expect( enemy_generator.enemy_table.class ).to eq EnemyTable
        expect( enemy_generator.enemy_table.enemies.size ).to eq 18
    end 

    it "can create an enemy from a given enemy symbol key" do 
        enemy_generator = EnemyGenerator.new 
        wolf_enemy = enemy_generator.create_enemy_from_key(:wolf)
        forest_troll = enemy_generator.create_enemy_from_key(:forest_troll)

        expect(wolf_enemy.class ).to eq Enemy
        expect(wolf_enemy.name ).to eq "Wolf"
        expect(forest_troll.class ).to eq Enemy
        expect(forest_troll.name ).to eq "Forest Troll"
    end

    it "returns nil if attempting to create an invalid enemy" do 
        enemy_generator = EnemyGenerator.new 
        expect( enemy_generator.create_enemy_from_key(:not_a_real_enemy) ).to eq nil 
    end 

    it "can create a random enemy from the enemy table" do 
        enemy_generator = EnemyGenerator.new 

        srand 100

        random_enemy_1 = enemy_generator.create_random_enemy()
        random_enemy_2 = enemy_generator.create_random_enemy()
        random_enemy_3 = enemy_generator.create_random_enemy()

        expect(random_enemy_1.class ).to eq Enemy
        expect(random_enemy_1.name ).to eq "Rattle Snake"
        expect(random_enemy_2.class ).to eq Enemy
        expect(random_enemy_2.name ).to eq "Forest Troll"
        expect(random_enemy_3.class ).to eq Enemy
        expect(random_enemy_3.name ).to eq "Armed Bandit"
    end
end