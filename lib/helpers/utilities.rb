require 'io/console'

def press_any_key_to_continue
    STDIN.iflush()
    puts "Press any key to continue"
    STDIN.getch
end 