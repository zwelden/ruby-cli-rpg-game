require 'json'

# Loads the contents of the item table json file into a holding object for querying
# The item table will contain all items that can be dynamically generated
class ItemTable
    TABLE_FILE_PATH = File.expand_path(File.dirname(__FILE__)) + '/tables'

    attr_reader :items

    # Load the json file into the items hash variable
    def initialize
        file_path = TABLE_FILE_PATH + '/item_table.json'
        file = File.read(file_path)
        @items = JSON.parse(file, {symbolize_names: true})
    end 

    # Get a hash object representing an item by was of a key symbol 
    #
    # @param [symbol] key - symbol value representing an item
    # @return [hash|nil] - hash object enumerating item characteristics
    def get_item_info_by_key(key)
        item = nil

        if @items.has_key?(key)
            item = @items[key]
        end 

        item
    end 
end 
