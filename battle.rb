require "./dice.rb"

class Battle 
    def initialize(player, map)
        player_x, player_y = player.coords

        @player = player 
        @tile = map.get_tile(player_x, player_y)
        @monsters = @tile.monsters

        battle_loop()
    end 

    def define_battle 
        system "clear"

        monster_info = ""

        @monsters.each_with_index do |monster, m_idx|
            name = monster.name 
            health = monster.health
            strength = monster.strength
            selection = m_idx + 1
            monster_info << "#{selection}.) #{name} - Health: #{health} Strength: #{strength}\n"
        end

        battle_detail = <<~END
            You have encountered monsters
            #{monster_info}
        END

        puts battle_detail

        puts "What would you like to do?"
        puts "Run (r)"
        puts "Fight (f)"
    end 

    def get_next_battle_action
        print "> "
        gets.chomp
    end

    def calculate_damage(attacker, attacked)
        is_crit = (Dice.d20 == 20)
        attack = Dice.d8 + attacker.strength 
        defense = Dice.d8 + attacked.defense 

        if (is_crit)
            attack *= 2 
        end 

        damage = attack - defense 

        if (damage > 0)
            if (is_crit) 
                puts "#{attacker.name} Cits!"
            end 
            puts "#{attacker.name} does #{damage} damage to #{attacked.name}"
        else 
            puts "#{attacker.name} misses #{attacked.name}"
        end 

        damage 
    end 

    def run_away 
        damage_taken = 0 
        @monsters.each do |monster|
            if (Dice.d10 >= 6)
                damage_taken += calculate_damage(monster, @player)
            end
        end 
        
        if (damage_taken > 0)
            puts "You ran away, but took #{damage_taken} damage in the process."
        else 
            puts "You ran away and managed to excape unharmed"
        end 
    end




    def handle_battle_action(action)
        case action
        when "r"
            run_away()
            @tile.defeat_monsters
            puts "Press any key to continue"
            gets
        when "f"
            @tile.defeat_monsters
            puts "You fought the monsters and won. +10 experience"
            puts "Press any key to continue"
            gets
        else
            puts "Invalid options. choose again."

            action = get_next_battle_action
            handle_battle_action(action)
        end
    end

    def battle_loop 
        define_battle()
        action = get_next_battle_action()
        handle_battle_action(action)
    end 
end 
