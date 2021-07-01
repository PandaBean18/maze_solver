class Solver
    attr_reader :arr, :parent_square, :open_list, :closed_list
    
    def initialize(arr)
        @arr = arr
        @parent_square = start_pos
        @parent_g_cost = 0
        @open_list = []
        @closed_list = []
    end

    def print_maze
        array = arr.clone
        array.each.with_index do |subarr, i|
            str = subarr.join("")
            array[i] = [str]
        end
        puts array.join("\n")
    end
            
    def start_pos
        i = 0 
        pos_x = 0
        pos_y = 0
        while i < arr.length
            if arr[i].include?("S")
                j = 0 
                while j < arr[i].length
                    if arr[i][j] == "S"
                        pos_x = i
                        pos_y = j
                    end
                    j += 1
                end
            end
            i += 1
        end
        return [pos_x, pos_y]
    end

    def end_pos
        i = 0
        pos_x = 0 
        pos_y = 0 
        while i < arr.length
            if arr[i].include?("E")
                j = 0 
                while j < arr[i].length
                    if arr[i][j] == "E"
                        pos_x = i
                        pos_y = j
                    end
                    j += 1
                end
            end
            i += 1
        end
        return [pos_x, pos_y]
    end

    def update_lists

        if @parent_square != self.start_pos
            @closed_list += [@parent_square]
            idx = @open_list.index(@parent_square)
            @open_list.delete_at(idx)
            @closed_list += [@open_list]
            @open_list = []
        end

        x = @parent_square[0]
        y = @parent_square[1]

        if @arr[x - 1][y] != "*" && !@closed_list.include?([(x - 1), y])
            @open_list << [(x - 1), y]
        end

        if @arr[x + 1][y] != "*" && !@closed_list.include?([(x + 1), y])
            @open_list << [(x + 1), y]
        end
        
        if @arr[x][y - 1] != "*" && !@closed_list.include?([x, (y - 1)])
            @open_list << [x, (y - 1)]
        end

        if @arr[x][y + 1] != "*" && !@closed_list.include?([x, (y + 1)])
            @open_list << [x, (y + 1)]
        end
    end

    def calc_g_cost
        g_cost = @parent_g_cost + 10
        return g_cost
    end

    def calc_h_cost(pos)
        h_cost = ((pos[0] - self.end_pos[0]).abs + (pos[1] - self.end_pos[1]).abs) * 10
        return h_cost
    end

    def calc_f_cost(pos)
        f_cost = self.calc_g_cost + self.calc_h_cost(pos)
        return f_cost
    end

    def choose_path
        i = 0
        hash = Hash.new(0)
        while i < self.open_list.length
            hash[self.open_list[i]] += calc_f_cost(self.open_list[i])
            i += 1
        end
        return hash.key(hash.values.sort[0])
    end

    def mark
        @arr[self.choose_path[0]][self.choose_path[1]] = "X"
        self.looper
    end
    
    def next!
        @parent_square = self.choose_path
        @parent_g_cost += 10
        self.mark
    end

    def looper
        self.update_lists
        if @parent_square == self.start_pos
            self.next!
        elsif @open_list == [] && @parent_square != self.start_pos
            puts "\n"
            puts "this maze has no solutions"

        elsif @open_list.include?(self.end_pos)
            puts "\n"
            self.print_maze
        else
            self.next!
        end
    end
end

