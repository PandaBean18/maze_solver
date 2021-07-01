require_relative "solver.rb"
def ask_user
    puts "please paste the maze. add 1 tab of space (4 spaces) in the last line"
    text = gets("\t\n").chomp
    File.write("input.txt", text, mode: "a")
    $maze = [] 
    File.open('input.txt').each_line do |str|
        arr = []
        str.chomp.strip.each_char do |x|
            arr << x
        end
        $maze << arr
    end

    File.open("input.txt", "w") {|file| file.truncate(0)}
    $solve = Solver.new($maze)
end

ask_user
$solve.looper
