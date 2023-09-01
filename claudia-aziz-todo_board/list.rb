require_relative "item.rb"
require "byebug"

class List
    attr_accessor :label

    def initialize(label)
        @label = label
        @items = []
    end

    def add_item(title, deadline, description = "")
        item = Item.new(title, deadline, description)
        return false if !item
        @items << item
        true
    end

    def size
        @items.length
    end

    def valid_index?(index)
        return false if index < 0 || @items.length < index
        true
    end

    def swap(index_1, index_2)
        return false if !valid_index?(index_1) || !valid_index?(index_2)
        @items[index_1], @items[index_2] = @items[index_2], @items[index_1]
        true
    end

    def [](index)
        return nil if !valid_index?(index)
        @items[index]
    end

    def priority
        @items[0]
    end

    def print
        puts "Index  |  Item  |  Deadline"
        @items.each_with_index do |item, i|
            puts "#{i}  #{item.title}  #{item.deadline}"
        end
    end

    def print_full_item(index)
        if valid_index?(index)
            item = @items[index]
            puts "#{item.title}"
            puts "#{item.description}"
            puts "#{item.deadline}"
        end
    end

    def print_priority
        item = @items[0]
        puts "#{item.title}"
        puts "#{item.description}"
        puts "#{item.deadline}"
    end

    def up(index, amount = 1)
        return false if !valid_index?(index) 

        new_idx = index
        amount.times do 
            return true if @items[new_idx] == @items[0]
            @items[new_idx-1], @items[new_idx] = @items[new_idx], @items[new_idx-1]
            new_idx -= 1
        end
        true 
    end

    def down(index, amount = 1)
        return false if !valid_index?(index) 

        new_idx = index
        amount.times do 
            return true if @items[new_idx] == @items[-1]
            @items[new_idx+1], @items[new_idx] = @items[new_idx], @items[new_idx+1]
            new_idx += 1
        end
        true 
    end

    def sort_by_date!
        @items.sort_by! { |item| item.deadline }
    end

end

# tests

# my_list = List.new('Groceries')
# #<List:0x @items=[], @label="Groceries">

# my_list.size
# # 0

# my_list.add_item('cheese', '2019-10-25', 'Get American and Feta for good measure.')
# # true

# my_list.add_item('toothpaste', '2019-10-25')
# # true

# # p my_list.add_item('shampoo', '10-24-2019') # invalid date
# # false

# my_list.add_item('shampoo', '2019-10-24')
# # true

# my_list.add_item('candy', '2019-10-31', '4 bags should be enough')
# # true

# my_list
# # #<List:0x
# #  @items=
# #   [#<Item:0x @title="cheese", @deadline="2019-10-25", @description="Get American and Feta for good measure.">,
#    #<Item:0x @title="toothpaste", @deadline="2019-10-25", @description="">,
#    #<Item:0x @title="shampoo", @deadline="2019-10-24", @description="">,
#    #<Item:0x @title="candy", @deadline="2019-10-31", @description="4 bags should be enough">],
# #  @label="Groceries">

# my_list.size
# # 4

# my_list.priority
# # #<Item:0x @title="cheese", @deadline="2019-10-25", @description="Get American and Feta for good measure.">

# my_list.swap(0,  2)
# # true

# my_list.priority
# #<Item:0x @title="shampoo", @deadline="2019-10-24", @description="">

# # my_list
# #<List:0x
# #  @items=
#   #<Item:0x @title="shampoo", @deadline="2019-10-24", @description="">,
#    #<Item:0x @title="toothpaste", @deadline="2019-10-25", @description="">,
#    #<Item:0x @title="cheese", @deadline="2019-10-25", @description="Get American and Feta for good measure.">,
#    #<Item:0x @title="candy", @deadline="2019-10-31", @description="4 bags should be enough">],
# #  @label="Groceries">

# my_list.swap(1,  7) # invalid index 7
# # false

# my_list[1]
# #<Item:0x @title="toothpaste", @deadline="2019-10-25", @description="">

# my_list[3]
# #<Item:0x @title="candy", @deadline="2019-10-31", @description="4 bags should be enough">

# my_list.swap(1,  3)
# #true

# my_list[1]
# #<Item:0x @title="candy", @deadline="2019-10-31", @description="4 bags should be enough">

# my_list[3]
# #<Item:0x @title="toothpaste", @deadline="2019-10-25", @description="">

# my_list.size

# my_list[4]

# my_list.print

# p my_list

# my_list.print_full_item(6)


# l = List.new('Groceries')
# # # #<List:0x00007fac66bedf38 @items=[], @label="Groceries">

# l.add_item('cheese', '2019-10-25')
# # # true

# l.add_item('toothpaste', '2019-10-25')
# # # true

# l.add_item('shampoo', '2019-10-24')
# # # true

# l.add_item('candy', '2019-10-31')
# # true

# # l.print
# # ------------------------------------------
# #                 GROCERIES
# # ------------------------------------------
# # Index | Item                 | Deadline
# # ------------------------------------------
# # 0     | cheese               | 2019-10-25
# # 1     | toothpaste           | 2019-10-25
# # 2     | shampoo              | 2019-10-24
# # 3     | candy                | 2019-10-31
# # ------------------------------------------
# # => nil

# l.down(0)
# # true

# # l.print
# # ------------------------------------------
# #                 GROCERIES
# # ------------------------------------------
# # Index | Item                 | Deadline
# # ------------------------------------------
# # 0     | toothpaste           | 2019-10-25
# # 1     | cheese               | 2019-10-25
# # 2     | shampoo              | 2019-10-24
# # 3     | candy                | 2019-10-31
# # ------------------------------------------
# # nil

# l.down(0, 2)
# # # true

# # l.print
# # # ------------------------------------------
# # #                 GROCERIES
# # # ------------------------------------------
# # # Index | Item                 | Deadline
# # # ------------------------------------------
# # # 0     | cheese               | 2019-10-25
# # # 1     | shampoo              | 2019-10-24
# # # 2     | toothpaste           | 2019-10-25
# # # 3     | candy                | 2019-10-31
# # # ------------------------------------------
# # # nil

# l.up(3, 10)
# # # true

# # l.print
# # # ------------------------------------------
# # #                 GROCERIES
# # # ------------------------------------------
# # # Index | Item                 | Deadline
# # # ------------------------------------------
# # # 0     | candy                | 2019-10-31
# # # 1     | cheese               | 2019-10-25
# # # 2     | shampoo              | 2019-10-24
# # # 3     | toothpaste           | 2019-10-25
# # # ------------------------------------------
# # # nil

# l.up(7, 3) # invalid index 7
# # # false

# # l.print

# # l.sort_by_date!

# # l.print


# l = List.new('Groceries')
# # #<List:0x @items=[], @label="Groceries">

# l.add_item('cheese', '2019-10-25')
# # true

# l.add_item('toothpaste', '2019-10-25')
# # true

# l.add_item('shampoo', '2019-10-24')
# # true

# l.add_item('candy', '2019-10-31')
# # true

# # l.print
# # ------------------------------------------
# #                 GROCERIES
# # ------------------------------------------
# # Index | Item                 | Deadline
# # ------------------------------------------
# # 0     | cheese               | 2019-10-25
# # 1     | toothpaste           | 2019-10-25
# # 2     | shampoo              | 2019-10-24
# # 3     | candy                | 2019-10-31
# # ------------------------------------------
# # => nil

# # l.sort_by_date!
# # => [#<Item:0x @deadline="2019-10-24", @description="", @title="shampoo">,
# #  #<Item:0x @deadline="2019-10-25", @description="", @title="cheese">,
# #  #<Item:0x @deadline="2019-10-25", @description="", @title="toothpaste">,
# #  #<Item:0x @deadline="2019-10-31", @description="", @title="candy">]

# # l.print
# # ------------------------------------------
# #                 GROCERIES
# # ------------------------------------------
# # Index | Item                 | Deadline
# # ------------------------------------------
# # 0     | shampoo              | 2019-10-24
# # 1     | cheese               | 2019-10-25
# # 2     | toothpaste           | 2019-10-25
# # 3     | candy                | 2019-10-31
# # ------------------------------------------
# # => nil