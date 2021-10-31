require "./dice.rb"

class Battle 
    def initialize(player, map)
        player_x, player_y = player.coords

        @player = player 
        @tile = map.get_tile(player_x, player_y)
        @monsters = @tile.monsters
        @in_battle = true

        battle_loop()
    end 

    def list_monster_targets 
        monster_info = ""

        @monsters.each_with_index do |monster, m_idx|
            name = monster.name 
            health = monster.health
            strength = monster.strength
            selection = m_idx + 1

            if monster.is_alive?
                monster_info << "#{selection}.) #{name} - Health: #{health} Strength: #{strength}\n"
            else 
                monster_info << "#{selection}.) #{name} - DEAD\n"
            end
        end
    
        monster_info 
    end

    def define_battle 
        system "clear"

        monster_info = list_monster_targets()

        battle_detail = <<~END
            You have encountered monsters
            #{monster_info}
        END

        puts battle_detail

        puts "#{@player.name} \n- Health: #{@player.health} \n- Strength: #{@player.strength} \n- Defense: #{@player.defense}\n\n"

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

        if (damage < 0)
            damage = 0 
        end 

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
        total_damage = 0 

        @monsters.each do |monster|
            if (monster.is_alive? && @player.is_alive? && Dice.d10 >= 5)
                damage_taken = calculate_damage(monster, @player)
                total_damage += damage_taken
                @player.reduce_health(damage_taken)
            elsif (@player.is_alive?)
                puts "#{monster.name} is caught flat footed and is unable to attack #{@player.name}"
            end
        end 
        
        if (@player.is_alive? == false)
            puts "You died trying to run away. Better luck next time"
        elsif (total_damage > 0)
            puts "You ran away, but took #{total_damage} damage in the process."
        else 
            puts "You ran away and managed to excape unharmed"
        end 

        if (@player.is_alive?)
            @tile.defeat_monsters
        end 

        @in_battle = false
        puts "Press any key to continue"
        gets
    end

    def select_monster 
        system "clear"
        monster_info = list_monster_targets()
        puts monster_info + "\n"
        puts "Which monster would you like to attack?"
        monster_number = gets.chomp.to_i
        monster_number -= 1

        if (monster_number >= 0 && monster_number < @monsters.length && @monsters[monster_number].is_alive?)
            return @monsters[monster_number] 
        else 
            return select_monster()
        end 
    end
        
    def fight_monster(monster)
        damage = calculate_damage(@player, monster)
        monster.reduce_health(damage)
    end 

    def monster_attacks 
        puts "The monster(s) attack"

        @monsters.each do |monster|
            if (monster.is_alive? && @player.is_alive?)
                damage_taken = calculate_damage(monster, @player)
                @player.reduce_health(damage_taken)
            end
        end 

        if (@player.is_alive? == false)
            puts "The monsters have killed you."
        else 
            puts "Monsters have finished attacking."
        end 
    end 

    def all_monsters_dead? 
        monster_alive = false 
        @monsters.each do |monster|
            if (monster.is_alive?)
                monster_alive = true 
            end 
        end 

        !monster_alive 
    end 
        
    def handle_battle_action(action)
        case action
        when "r"
            run_away()
            
        when "f"
            monster = select_monster()
            fight_monster(monster)

            if (all_monsters_dead?())
                @tile.defeat_monsters
                puts "You fought the monsters and won. +10 experience"
            else 
                monster_attacks()
            end 

            puts "Press any key to continue"
            gets

        else
            puts "Invalid options. choose again."
            action = get_next_battle_action
            handle_battle_action(action)

        end
    end

    def battle_loop 
        while(@player.is_alive? && all_monsters_dead?() == false && @in_battle == true) 
            define_battle()
            action = get_next_battle_action()
            handle_battle_action(action)
        end
    end 
end 
