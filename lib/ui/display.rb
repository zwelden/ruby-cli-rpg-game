require 'helpers/utilities'

class Display 

    def self.player_info(player)
        player_name_str = player.name.ljust(39, ' ');
        health_str = "Health: #{player.health}".ljust(18, ' ')
        strength_str = "Strength: #{player.strength}".ljust(18, ' ')
        defense_str = "Defense: #{player.defense}".ljust(18, ' ')
        gold_str = "Gold: #{player.gold}".ljust(18, ' ')
        experience_str = "Experience: #{player.experience}".ljust(18, ' ')
        place_holder = "".ljust(18, ' ')

        display_info = <<~END 
            ╒═════════════════════════════════════════╕
            │ #{player_name_str} │
            ├────────────────────┬────────────────────┤
            │ #{health_str} │ #{strength_str} │
            │ #{defense_str} │ #{place_holder} │
            │ #{gold_str} │ #{experience_str} │
            ╘════════════════════╧════════════════════╛

        END

        puts display_info
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
            enemy_name_str = (enemy_num.to_s + '.) ' + enemy.name).ljust(33, ' ');

            display_info = <<~END 
                ╒═══════════════════════════════════╕
                │ #{enemy_name_str} │
                ├─────────────────┬─────────────────┤
                │ #{health_str} │ #{strength_str} │
                │ #{defense_str} │ #{place_holder} │
                ╘═════════════════╧═════════════════╛
            END
        else 
            enemy_name_str = (enemy_num.to_s + '.) ' + enemy.name).ljust(33, ' ').colorize("linethrough");

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
            | MOVEMENT                                          |
            │ w - move up                                       |
            | s - move down                                     |
            | a - move left                                     |
            | d - move right                                    |
            |                                                   |
            | OTHER                                             | 
            | sleep - rest player and restore 1/2 max health    |
            | help - displays this screen                       |
            ╘═══════════════════════════════════════════════════╛
        
        END

        puts display 
        press_any_key_to_continue()
    end
end
