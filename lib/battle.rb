require 'io/console'
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
        @ran_away = false

        battle_loop()
    end 

    def define_battle 
        system "clear"

        puts "You have encountered enemies"
        Display.display_all_enemy_info(@enemies)
        Display.player_info(@player)

        STDIN.iflush
        puts "What would you like to do?"
        puts "r - Run"
        puts "f - Fight"
    end 

    def get_next_battle_action
        print "> "
        gets.chomp
    end

    def calculate_damage(attacker, defender)
        is_crit = (Dice.d20 == 20)

        attack = Dice.d10 + attacker.strength + attacker.get_attack_power
        defense = Dice.d6 + defender.defense + defender.get_armor

        if (is_crit)
            attack *= 2 
            defense /= 2
        end 

        damage = attack - defense 

        if (damage < 0)
            damage = 0 
            is_crit = false
        end 

        [damage, is_crit] 
    end 

    def display_damage_done(damage, is_crit, attacker, defender)
        atk_color = "red"
        def_color = "green"

        if (attacker.class == Player)
            atk_color = "green"
            def_color = "red"
        end

        if (damage > 0)
            if (is_crit)
                crit_str = "Crits".colorize("cyan") 
                puts "#{attacker.name.colorize(atk_color)} #{crit_str}!"
            end 
            puts "#{attacker.name.colorize(atk_color)} does #{damage.to_s.colorize(atk_color)} damage to #{defender.name.colorize(def_color)}"
        else 
            puts "#{attacker.name.colorize(atk_color)} misses #{defender.name.colorize(def_color)}"
        end 
    end 

    def run_away 
        total_damage = 0 

        @enemies.each do |enemy|
            if (enemy.is_alive? && @player.is_alive? && Dice.d10 >= 5)
                damage_taken, is_crit = calculate_damage(enemy, @player)
                display_damage_done(damage_taken, is_crit, enemy, @player)
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
        @ran_away = true
    end

    def select_enemy 
        system "clear"
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

        STDIN.iflush
        puts "Which enemy would you like to attack?"
        enemy_number = gets.chomp.to_i
        enemy_number -= 1

        if (enemy_number >= 0 && enemy_number < @enemies.length && @enemies[enemy_number].is_alive?)
            return @enemies[enemy_number] 
        else 
            return select_enemy()
        end 
    end

    def fight 
        enemy = select_enemy()
        attack_enemy(enemy)

        if (all_enemies_dead?())
            @tile.defeat_enemies
            puts "You fought the enemies and won."
        else 
            enemy_attacks()
        end 

        press_any_key_to_continue()
    end
        
    def attack_enemy(enemy)
        damage, is_crit = calculate_damage(@player, enemy)
        enemy.reduce_health(damage)
        system "clear"
        Display.display_all_enemy_info(@enemies)
        display_damage_done(damage, is_crit, @player, enemy)

        if (enemy.is_alive? == false)
            exp = enemy.reward_experience() 
            @player.increase_experience(exp)
            puts "#{@player.name} kills #{enemy.name}"
        end 
    end 

    def enemy_attacks 
        puts "The enemy(s) attack"

        @enemies.each do |enemy|
            if (enemy.is_alive? && @player.is_alive?)
                damage_taken, is_crit = calculate_damage(enemy, @player)
                display_damage_done(damage_taken, is_crit, enemy, @player)
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

    def get_battle_loot
        gold = 0 
        inventory = []

        @enemies.each do |enemy|
            gold += enemy.gold 
            if (enemy.inventory.length > 0)
                inventory.concat(enemy.inventory)
            end 
        end 

        [gold, inventory]
    end 

    def update_player_loot(gold, inventory)
        @player.add_gold(gold) 
        @player.add_inventory(inventory)
    end
        
    def handle_battle_action(action)
        case action
        when "r"
            run_away()
            
        when "f"
            fight()

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

        if (@ran_away == false && @player.is_alive? && all_enemies_dead?())
            gold, inventory = get_battle_loot() 
            update_player_loot(gold, inventory)
            puts "VICTORY"
            
            if (gold > 0)
                puts "You were able to loot #{gold} gold"
            end 

            if (inventory.length > 0)
                puts "You looted the following items: "
                inventory.each do |item|
                    puts "- #{item}"
                end  
            end
        end 

        press_any_key_to_continue()

    end 
end 
