require 'character/enemy'

class EnemyGenerator 
    ENEMIES = {
        bandit: {
            name: "Bandit",
            health: 10, 
            strength: 2, 
            defense: 2,
            level: 1
        },
        goul: {
            name: "Goul",
            health: 10, 
            strength: 1, 
            defense: 1,
            level: 1 
        },
        rat: {
            name: "Rat",
            health: 5, 
            strength: 5, 
            defense: 1,
            level: 1 
        },
        skeleton: {
            name: "Skeleton",
            health: 10, 
            strength: 5, 
            defense: 1,
            level: 1 
        },
        zombie: {
            name: "Zombie",
            health: 20, 
            strength: 3, 
            defense: 2,
            level: 1 
        }
    }
    
    def self.create_random_enemy 
        self.create_enemy_from_const(ENEMIES.keys.sample)
    end 

    def new_bandit 
        self.create_enemy_from_const(:bandit)
    end 

    def new_goul 
        self.create_enemy_from_const(:goul)
    end 

    def new_rat 
        self.create_enemy_from_const(:rat)
    end 

    def new_skeleton 
        self.create_enemy_from_const(:skeleton)
    end 

    def new_zombie 
        self.create_enemy_from_const(:zombie)
    end 


    private
        def self.create_enemy_from_const(enemy)
            enemy = ENEMIES[enemy]
            name = enemy.key?(:name) ? enemy[:name] : 'Unknown enemy'
            health = enemy.key?(:health) ? enemy[:health] : 10
            strength = enemy.key?(:strength) ? enemy[:strength] : 1
            defense = enemy.key?(:defense) ? enemy[:defense] : 1
            level = enemy.key?(:level) ? enemy[:level] : 1
            Enemy.new(name, health, strength, defense, level)
        end 

end