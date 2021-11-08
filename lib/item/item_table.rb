require 'json'

class ItemTable
    TABLE_FILE_PATH = File.expand_path(File.dirname(__FILE__)) + '/tables'

    attr_reader :items

    def initialize
        file_path = TABLE_FILE_PATH + '/item_table.json'
        file = File.read(file_path)
        @items = JSON.parse(file, {symbolize_names: true})
    end 

    def get_item_info_by_key(key)
        item = nil

        if @items.has_key?(key)
            item = @items[key]
        end 

        item
    end 
end 
