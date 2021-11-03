require "helpers/dice"
require 'helpers/utilities'
require 'helpers/string_colorize'
require 'ui/display'

class Battle 
    def initialize(player, map)
        player_x, player_y = player.coords

        @player = player 
        @tile = map.get_tile(player_x, player_y)
        @enemies = @tile.enemies
        @in_battle = true

        battle_loop()
    end 

    def list_enemy_targets 
        enemy_info = ""

        enemy_info = display_all_enemy_info(@enemies)

        # @enemies.each_with_index do |enemy, m_idx|
        #     name = enemy.name 
        #     health = enemy.health
        #     strength = enemy.strength
        #     selection = m_idx + 1

        #     if enemy.is_alive?
        #         enemy_info << "#{selection}.) #{name} - Health: #{health} Strength: #{strength}\n"
        #     else 
        #         enemy_info << "#{selection}.) #{name} - DEAD\n"
        #     end
        # end
    
        enemy_info 
    end

    def define_battle 
        system "clear"

        # enemy_info = list_enemy_targets()

        # battle_detail = <<~END
        #     You have encountered enemies
        #     #{enemy_info}
        # END

        puts "You have encountered enemies"
        Display.display_all_enemy_info(@enemies)

        # puts battle_detail

        Display.player_info(@player)

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

        @enemies.each do |enemy|
            if (enemy.is_alive? && @player.is_alive? && Dice.d10 >= 5)
                damage_taken = calculate_damage(enemy, @player)
                total_damage += damage_taken
                @player.reduce_health(damage_taken)
            elsif (@player.is_alive?)
                puts "#{enemy.name} is caught flat footed and is unable to attack #{@player.name}"
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
            @tile.defeat_enemies
        end 

        @in_battle = false
        press_any_key_to_continue()
    end

    def select_enemy 
        system "clear"
        # enemy_info = list_enemy_targets()
        # puts enemy_info + "\n"

        Display.display_all_enemy_info(@enemies)

        live_enemies = 0
        first_live_enemy = nil

        @enemies.each do |enemy|
            if enemy.is_alive?
                if first_live_enemy == nil 
                    first_live_enemy = enemy 
                end 
                live_enemies += 1 
            end 
        end 

        if live_enemies == 1 
            return first_live_enemy 
        end 

        
        puts "Which enemy would you like to attack?"
        enemy_number = gets.chomp.to_i
        enemy_number -= 1

        if (enemy_number >= 0 && enemy_number < @enemies.length && @enemies[enemy_number].is_alive?)
            return @enemies[enemy_number] 
        else 
            return select_enemy()
        end 
    end
        
    def fight_enemy(enemy)
        damage = calculate_damage(@player, enemy)
        enemy.reduce_health(damage)

        if (enemy.is_alive? == false)
            puts "#{@player.name} kills #{enemy.name}"
        end 
    end 

    def enemy_attacks 
        puts "The enemy(s) attack"

        @enemies.each do |enemy|
            if (enemy.is_alive? && @player.is_alive?)
                damage_taken = calculate_damage(enemy, @player)
                @player.reduce_health(damage_taken)
            end
        end 

        if (@player.is_alive? == false)
            puts "The enemies have killed you."
        else 
            puts "enemies have finished attacking."
        end 
    end 

    def all_enemies_dead? 
        enemy_alive = false 
        @enemies.each do |enemy|
            if (enemy.is_alive?)
                enemy_alive = true 
            end 
        end 

        !enemy_alive 
    end 
        
    def handle_battle_action(action)
        case action
        when "r"
            run_away()
            
        when "f"
            enemy = select_enemy()
            fight_enemy(enemy)

            if (all_enemies_dead?())
                @tile.defeat_enemies
                puts "You fought the enemies and won. +10 experience"
            else 
                enemy_attacks()
            end 

            press_any_key_to_continue()

        else
            puts "Invalid options. choose again."
            action = get_next_battle_action
            handle_battle_action(action)

        end
    end

    def battle_loop 
        while(@player.is_alive? && all_enemies_dead?() == false && @in_battle == true) 
            define_battle()
            action = get_next_battle_action()
            handle_battle_action(action)
        end
    end 
end 
