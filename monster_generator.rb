require './monster.rb'

class MonsterGenerator 
    MONSTERS = {
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
    
    def self.create_random_monster 
        monster = MONSTERS[MONSTERS.keys.sample]
        self.create_monster_from_const(monster)
    end 

    def new_bandit 
        self.create_monster_from_const(MONSTERS[:bandit])
    end 

    def new_goul 
        self.create_monster_from_const(MONSTERS[:goul])
    end 

    def new_rat 
        self.create_monster_from_const(MONSTERS[:rat])
    end 

    def new_skeleton 
        self.create_monster_from_const(MONSTERS[:skeleton])
    end 

    def new_zombie 
        self.create_monster_from_const(MONSTERS[:zombie])
    end 


    private
        def self.create_monster_from_const(monster)
            name = monster.key?(:name) ? monster[:name] : 'Unknown Monster'
            health = monster.key?(:health) ? monster[:health] : 10
            strength = monster.key?(:strength) ? monster[:strength] : 1
            defense = monster.key?(:defense) ? monster[:defense] : 1
            level = monster.key?(:level) ? monster[:level] : 1
            Monster.new(name, health, strength, defense, level)
        end 

end