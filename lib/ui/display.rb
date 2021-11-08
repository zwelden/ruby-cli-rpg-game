require 'helpers/utilities'

class Display 

    def self.player_info(player)
        player_name_str = player.name.ljust(51, ' ').colorize("green")
        health_str = "Health: #{player.health}".ljust(24, ' ')
        strength_str = "Strength: #{player.strength}".ljust(24, ' ')
        attack_power_str = "Attack Power: #{player.get_attack_power}".ljust(24, ' ')
        defense_str = "Defense: #{player.defense}".ljust(24, ' ')
        armor_str = "Armor: #{player.get_armor}".ljust(24, ' ')
        gold_str = "Gold: #{player.gold}".ljust(24, ' ')
        experience_str = "Experience: #{player.experience}".ljust(24, ' ')
        place_holder = "".ljust(24, ' ')

        display_info = <<~END 
            ╒═════════════════════════════════════════════════════╕
            │ #{player_name_str} │
            ├──────────────────────────┬──────────────────────────┤
            │ #{gold_str} │ #{experience_str} │
            ├──────────────────────────┼──────────────────────────┤
            │ #{health_str} │ #{place_holder} │
            │ #{strength_str} │ #{attack_power_str} │
            │ #{defense_str} │ #{armor_str} │
            ╘══════════════════════════╧══════════════════════════╛
        END

        puts display_info
    end 

    def self.player_equipped_items(player)
        weapon = player.weapon_slot.respond_to?(:name) ? player.weapon_slot.to_s : ""
        shield = player.shield_slot.respond_to?(:name) ? player.shield_slot.to_s : ""
        body_armor = player.body_slot.respond_to?(:name) ? player.body_slot.to_s : ""
        leg_armor = player.leg_slot.respond_to?(:name) ? player.leg_slot.to_s : ""
        weapon_str = weapon.ljust(24, ' ')
        shield_str = shield.ljust(24, ' ')
        body_armor_str = body_armor.ljust(24, ' ')
        leg_armor_str = leg_armor.ljust(24, ' ')
        
        display_info = <<~END 
            ╒═════════════════════════════════════════════════════╕
            │ EQUIPPED ITEMS                                      │
            ├──────────────────────────┬──────────────────────────┤
            │ WEAPON                   │ SHIELD                   │
            │ #{weapon_str} │ #{shield_str} │
            ├──────────────────────────┼──────────────────────────┤
            │ BODY                     │ LEGS                     │
            │ #{body_armor_str} │ #{leg_armor_str} │
            ╘══════════════════════════╧══════════════════════════╛
        END

        puts display_info
    end

    def self.player_inventory(player)
        display_info = <<~END 
            ╒═════════════════════════════════════════════════════╕
            │ INVENTORY                                           │
            ├──────────────────────────┬──────────────────────────┤
        END

        inventory_index = 0
        if (player.inventory.respond_to?(:each_slice))
            player.inventory.each_slice(2) do |item_a, item_b|
                inventory_index += 1
                item_a_str = item_a.respond_to?(:name) ? "#{inventory_index}. " + item_a.to_s : ""
                inventory_index += 1
                item_b_str = item_b.respond_to?(:name) ? "#{inventory_index}. " + item_b.to_s : ""
                item_a_display = item_a_str.ljust(24, ' ')
                item_b_display = item_b_str.ljust(24, ' ')
                display_info << "│ #{item_a_display} │ #{item_b_display} │\n"
            end 
        end 

        display_info << "╘══════════════════════════╧══════════════════════════╛"
                
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
            enemy_name_str = (enemy_num.to_s + '.) ' + enemy.name).ljust(33, ' ').colorize("red")

            display_info = <<~END 
                ╒═══════════════════════════════════╕
                │ #{enemy_name_str} │
                ├─────────────────┬─────────────────┤
                │ #{health_str} │ #{strength_str} │
                │ #{defense_str} │ #{place_holder} │
                ╘═════════════════╧═════════════════╛
            END
        else 
            enemy_name_str = (enemy_num.to_s + '.) ' + enemy.name).ljust(33, ' ').colorize("red").colorize("linethrough")

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

    def self.inventory_options
        display = <<~END
            ╒═══════════════════════════════════════════════════╕
            │ OPTIONS                                           │
            │ b - back to game                                  │
            │ e - equip item                                    │
            │ u - unequip item                                  │
            │ c - use item                                      │
            │ d - drop item                                     │
            │ v - view item                                     │
            ╘═══════════════════════════════════════════════════╛
        
        END

        puts display 
        press_any_key_to_continue()
    end

    def self.show_item_detail(item)
        item_name_str = item.name.ljust(51, ' ').colorize("green")
        item_type_str = ("Type: " + item.type.to_s.capitalize).ljust(51, ' ')

        display_info = <<~END 
            ╒═════════════════════════════════════════════════════╕
            │ #{item_name_str} │
            ├─────────────────────────────────────────────────────┤
            │ #{item_type_str} │ 
        END

        case item.type
        when :armor
            armor_type_str = ("Slot: " + item.armor_type.to_s.capitalize).ljust(51, ' ')
            armor_str = ("Armor: " + item.armor.to_s).ljust(51, ' ')
            display_info << "│ #{armor_type_str} │\n│ #{armor_str} │\n"

        when :weapon
            power_str = ("Power: " + item.power.to_s).ljust(51, ' ')
            display_info << "│ #{power_str} │\n"

        when :shield
            armor_str = ("Armor: " + item.armor.to_s).ljust(51, ' ')
            display_info << "│ #{armor_str} │\n"

        when :potion
            health_points_str = ("Health: " + item.health_points.to_s).ljust(51, ' ')
            display_info << "│ #{health_points_str} │\n"
            
        end

        display_info << "╘═════════════════════════════════════════════════════╛"

        puts display_info
    end 

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
            \\'.  ||:::::.-!()oo @!()@.-'_.|
             '.'-;|:.-'.&$@.& ()$%-'o.'\\U||
               `>'-.!@%()@'@_%-'_.-o _.|'||
                ||-._'-.@.-'_.-' _.-o  |'||
                ||=[ '-._.-\\U/.-'    o |'||
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
