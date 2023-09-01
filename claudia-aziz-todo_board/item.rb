require "byebug"

class Item
    def Item.valid_date?(date_string)
        parts = date_string.split("-").map(&:to_i)
        month = parts[1]
        day = parts[2]
        return false if !(0..12).include?(month) || !(0..31).include?(day)
        true
    end

    attr_reader :deadline
    attr_accessor :title, :description

    def initialize(title, deadline, description)
        raise "invalid date" if !Item.valid_date?(deadline)
        @title = title
        @deadline = deadline
        @description = description
    end
    
    def deadline=(new_deadline)
        raise "invalid date" if !Item.valid_date?(new_deadline)
        @deadline = new_deadline
    end

end

# tests 

# p Item.valid_date?('2019-10-25') # true
# p Item.valid_date?('1912-06-23') # true
# p Item.valid_date?('2018-13-20') # false
# p Item.valid_date?('2018-12-32') # false
# p Item.valid_date?('10-25-2019') # false

# p Item.new('Fix login page', '2019-10-25', 'The page loads too slow.')
# p Item.new(
#     'Buy Cheese',
#     '2019-10-21',
#     'You require American, Swiss, Feta, and Mozzarella cheese for the Happy hour!'
# )
# p Item.new(
#     'Fix checkout page',
#     '10-25-2019',
#     'The font is too small.'
# ) # raises error due to invalid date

# p my_item = Item.new('Fix login page', '2019-10-42', 'It loads slow.')
# RuntimeError: deadline is not valid
# my_item = Item.new('Fix login page', '2019-10-22', 'It loads slow.')
#<Item:0x
        # @deadline="2019-10-22",
        # @description="It loads slow.",
        # @title="Fix login page">
# p my_item.title
# "Fix login page"
# my_item.description = 'It loads waaaaaay too slow!'
# "It loads waaaaaay too slow!"
# p my_item
#<Item:0x
        # @deadline="2019-10-22",
        # @description="It loads waaaaaay too slow!",
        # @title="Fix login page">
# p my_item.deadline = "10-23-2019"
# RuntimeError: deadline is not valid
# p my_item.deadline
# "2019-10-22"
# p my_item.deadline = "2019-10-23"
# "2019-10-23"
# p my_item.deadline
# "2019-10-23"
# p my_item
#<Item:0x
    # @deadline="2019-10-23",
    # @description="It loads waaaaaay too slow!",
    #  @title="Fix login page">
