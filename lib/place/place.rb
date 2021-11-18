# Class that represents a visitable place on a map
class Place 
    attr_reader :name
    attr_reader :type
    
    # init 
    #
    # @param [string] name - name of place 
    # @param [symbol] type - type of place, ex: :shop
    def initialize(name, type)
        @name = name 
        @type = type 
    end 

    # MEANT TO BE OVERWRITTEN
    # function defines what occurs when a place is interacted with
    def view_place
        puts "Entering #{@name}"
    end 
end 