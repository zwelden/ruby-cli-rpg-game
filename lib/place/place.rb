class Place 
    attr_reader :name
    attr_reader :type
    
    def initialize(name, type)
        @name = name 
        @type = type 
    end 

    # MEANT TO BE OVERWRITTEN
    def view_place
        puts "Entering #{@name}"
    end 
end 