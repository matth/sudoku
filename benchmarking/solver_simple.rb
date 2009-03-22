$:.unshift File.join(File.dirname(__FILE__), "..", "lib")
$:.unshift File.dirname(__FILE__)

require 'sudoku/grid'
require 'sudoku/solver/simple'


hard_puzzles = [
	"..1..4.......6.3.5...9.....8.....7.3.......285...7.6..3...8...6..92......4...1...",
	"1.......2.9.4...5...6...7...5.9.3.......7.......85..4.7.....6...3...9.8...2.....1",
	".......39.....1..5..3.5.8....8.9...6.7...2...1..4.......9.8..5..2....6..4..7.....",
	".2.4.37.........32........4.4.2...7.8...5.........1...5.....9...3.9....7..1..86..",
	".......39.....1..5..3.5.8....8.9...6.7...2...1..4.......9.8..5..2....6..4..7....."
].each {|puzzle|

	start = Time.now
	
	grid = Sudoku::Grid.new(puzzle)
	solver = Sudoku::Solver::Simple.new(grid)
	
	duration = Time.now - start
	
	puts solver.solutions[0].pretty_print
	puts "Solution found in #{duration} seconds"

}




