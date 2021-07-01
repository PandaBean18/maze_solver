#this is the main file that u need to run. keep solver, input.txt and this file in the same folder. input is an empty file, i have used it to store the input and 
#convert it into an array. i have also made it so after each run it will delete all the contents in the input.txt file as they are not required and will only come
#in the way if you decide to run it again.

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
