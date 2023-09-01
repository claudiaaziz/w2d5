class TodoBoard
    
    def initialize(label)
        @label = label
    end

    def get_command
        puts "Enter a command"
        command, *args = gets.chomp.split

        case command
        when 'mktodo'
            title = args[1]
            deadline = args[2]
            description = args[3] || ""
            @items.add_item(title, deadline, description)
            true
        when "up"
            optional = args[2] || 1
            @items.up(args[1], optional)
            true
        when "down"
            optional = args[2] || 1
            @items.down(args[1], optional)
            true
        when 'swap'
            @items.swap(args[1], args[2])
            true
        when 'sort'
            @items.sort_by_date!
            true
        when 'priority'
            @items.print_priority
            true
        when 'print'
            if !args[1]
                @items.print
            else
                @items.print_full_item(args[1])
            end
            true
        when 'quit'
            return false
        else
            puts "Sorry, that command is not recognized."
        end

        true
    end
end

l = List.new
mktodo cheese 2019-10-25 foooooood
mktodo toothpaste 2019-10-23
mktodo candy 2019-10-31 sugar-free
mktodo shampoo 2019-10-25
print
sort
print
swap 0 3
print
print 1
priority
down 0
print
up 3 2
print