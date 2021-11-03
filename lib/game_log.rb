require 'logger'

class GameLog < Logger
    def initialize 
        path = File.dirname(File.expand_path('..', __FILE__))
        super(path + '/logs/game_log.log')
    end 
end 
