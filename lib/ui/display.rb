require 'helpers/utilities'
require 'game_log'

class Display 

    def self.player_info(player)
        player_name_str = player.name.ljust(43, ' ').colorize("green");
        health_str = "Health: #{player.health}".ljust(20, ' ')
        strength_str = "Strength: #{player.strength}".ljust(20, ' ')
        attack_power_str = "Attack Pwr: #{player.get_attack_power}".ljust(20, ' ')
        defense_str = "Defense: #{player.defense}".ljust(20, ' ')
        armor_str = "Armor: #{player.get_armor}".ljust(20, ' ')
        gold_str = "Gold: #{player.gold}".ljust(20, ' ')
        experience_str = "Exp: #{player.experience}".ljust(20, ' ')
        place_holder = "".ljust(20, ' ')

        display_info = <<~END 
            ╒═════════════════════════════════════════════╕
            │ #{player_name_str} │
            ├──────────────────────┬──────────────────────┤
            │ #{gold_str} │ #{experience_str} │
            ├──────────────────────┼──────────────────────┤
            │ #{health_str} │ #{place_holder} │
            │ #{strength_str} │ #{attack_power_str} │
            │ #{defense_str} │ #{armor_str} │
            ╘══════════════════════╧══════════════════════╛
        END

        puts display_info
    end 

    def self.player_equipped_items(player)
        worn_item = player.worn_item.respond_to?(:wearable) ? player.worn_item.to_s : ""
        equipped_item = player.equipped_item.respond_to?(:equipable) ? player.equipped_item.to_s : ""
        worn_item_str = worn_item.ljust(20, ' ')
        equipped_item_str = equipped_item.ljust(20, ' ')
        
        display_info = <<~END 
            ╒═════════════════════════════════════════════╕
            │ EQUIPPED ITEMS                              │
            ├──────────────────────┬──────────────────────┤
            │ WORN                 │ WEAPON/SHIELD        │
            │ #{worn_item_str} │ #{equipped_item_str} │
            ╘══════════════════════╧══════════════════════╛
        END

        puts display_info
    end

    def self.player_inventory(player)
        display_info = <<~END 
            ╒═════════════════════════════════════════════╕
            │ INVENTORY                                   │
            ├──────────────────────┬──────────────────────┤
        END

        if (player.inventory.respond_to?(:each_slice))
            player.inventory.each_slice(2) do |item_a, item_b|
                item_a_str = item_a.respond_to?(:name) ? item_a.to_s : ""
                item_b_str = item_b.respond_to?(:name) ? item_b.to_s : ""
                item_a_display = item_a_str.ljust(20, ' ')
                item_b_display = item_b_str.ljust(20, ' ')
                display_info << "│ #{item_a_display} │ #{item_b_display} │\n"
            end 
        end 

        display_info << "╘══════════════════════╧══════════════════════╛"
                
        puts display_info
    end 

    def self.full_player_info(player)
        puts self.player_info(player)
        puts self.player_equipped_items(player)
        puts self.player_inventory(player)
    end 

    def self.display_all_enemy_info(enemies)
        display_arr = []
        line = []
        display_str = ""

        enemies.each_with_index do |enemy, enemy_idx|
            enemey_num = enemy_idx + 1
            enemey_str = self.display_enemy_info(enemy, enemey_num)
            line.push(enemey_str)
            if (enemy_idx % 2 == 1)
                display_arr.push(line.clone)
                line = []
            elsif (enemy_idx + 1 == enemies.length)
                display_arr.push(line.clone)
                line = [] 
            end 
        end 

        display_arr.each do |display_line|
            if (display_line.length > 1)
                enemy_a = display_line[0].split("\n")
                enemy_b = display_line[1].split("\n")
                max_lines = [enemy_a.length, enemy_b.length].max

                max_lines.times do |line_no|
                    display_str << enemy_a[line_no] + "  " + enemy_b[line_no] + "\n"
                end 
            else 
                display_str << display_line[0] + "\n"
            end 
        end 

        puts display_str
    end 

    def self.display_enemy_info(enemy, enemy_num=1)
        health_str = "Health: #{enemy.health}".ljust(15, ' ')
        strength_str = "Strength: #{enemy.strength}".ljust(15, ' ')
        defense_str = "Defense: #{enemy.defense}".ljust(15, ' ')
        place_holder = "".ljust(15, ' ')

        if (enemy.is_alive?)
            enemy_name_str = (enemy_num.to_s + '.) ' + enemy.name).ljust(33, ' ').colorize("red");

            display_info = <<~END 
                ╒═══════════════════════════════════╕
                │ #{enemy_name_str} │
                ├─────────────────┬─────────────────┤
                │ #{health_str} │ #{strength_str} │
                │ #{defense_str} │ #{place_holder} │
                ╘═════════════════╧═════════════════╛
            END
        else 
            enemy_name_str = (enemy_num.to_s + '.) ' + enemy.name).ljust(33, ' ').colorize("red").colorize("linethrough");

            display_info = <<~END 
                ╒═══════════════════════════════════╕
                │ #{enemy_name_str} │
                ├───────────────────────────────────┤
                │ DEAD                              │
                │                                   │
                ╘═══════════════════════════════════╛
            END
        end

        display_info
    end 


    def self.action_options
        display = <<~END
            ╒═══════════════════════════════════════════════════╕
            │ MOVEMENT                                          │
            │ w - move up                                       │
            │ s - move down                                     │
            │ a - move left                                     │
            │ d - move right                                    │
            │                                                   │
            │ OTHER                                             │ 
            │ sleep - rest player and restore 1/2 max health    │
            │ i - show player inventory                         │
            │ c - show full player details                      │
            │ help - displays this screen                       │
            ╘═══════════════════════════════════════════════════╛
        
        END

        puts display 
        press_any_key_to_continue()
    end

    # def self.show_inventory(player)
    #     puts "<><> INVENTORY <><>"

    #     player.inventory.each do |item|
    #         puts "- #{item}"
    #     end 
    #     puts "\n"
    #     press_any_key_to_continue()
    # end

    def self.treasure_found 
        display_str = <<~END 
                    YOU FOUND TREASURE!

                             _.--.
                         _.-'_:-'||
                     _.-'_.-::::'||
                _.-:'_.-::::::'  ||
              .'`-.-:::::::'     ||
             /.'`;|:::::::'      ||_
            ||   ||::::::'     _.;._'-._
            ||   ||:::::'  _.-!oo @.!-._'-.
            \'.  ||:::::.-!()oo @!()@.-'_.|
             '.'-;|:.-'.&$@.& ()$%-'o.'\U||
               `>'-.!@%()@'@_%-'_.-o _.|'||
                ||-._'-.@.-'_.-' _.-o  |'||
                ||=[ '-._.-\U/.-'    o |'||
                || '-.]=|| |'|      o  |'||
                ||      || |'|        _| ';
                ||      || |'|    _.-'_.-'
                |'-._   || |'|_.-'_.-'
                 '-._'-.|| |' `_.-'
                     '-.||_/.-'

        END

        puts display_str
    end 
end
