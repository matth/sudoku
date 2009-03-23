
# A lot of these test cases come from:
# http://www.sudopedia.org/wiki/Invalid_Test_Cases
# http://www.sudopedia.org/wiki/Valid_Test_Cases

class TestSolverSimple < Test::Unit::TestCase

	def test_valid_puzzles
	
		puzzles = [
					{
						:puzzle => "974236158638591742125487936316754289742918563589362417867125394253649871491873625",
						:solution => "974236158638591742125487936316754289742918563589362417867125394253649871491873625"
					},
					{
						:puzzle => "2564891733746159829817234565932748617128.6549468591327635147298127958634849362715",
						:solution => "256489173374615982981723456593274861712836549468591327635147298127958634849362715"
					},				
					{
						:puzzle => "3.542.81.4879.15.6.29.5637485.793.416132.8957.74.6528.2413.9.655.867.192.965124.8",
						:solution => "365427819487931526129856374852793641613248957974165283241389765538674192796512438"
					},							
					{
						:puzzle => "..2.3...8.....8....31.2.....6..5.27..1.....5.2.4.6..31....8.6.5.......13..531.4..",
						:solution => "672435198549178362831629547368951274917243856254867931193784625486592713725316489"
					}
				]
		
		puzzles.each{|puzzle|			
			grid = Sudoku::Grid.new(puzzle[:puzzle])
			solver = Sudoku::Solver::Simple.new(grid)
			assert_equal(puzzle[:solution], solver.solutions[0].to_s)				
		}
				
	end

	def test_not_enough_givens
		grid = Sudoku::Grid.new("...........5....9...4....1.2....3.5....7.....438...2......9.....1.4...6..........")
		assert_raise(Exception) {Sudoku::Solver::Simple.new(grid)}
	end
	
	def test_invalid_duplicate_box
		grid = Sudoku::Grid.new("..9.7...5..21..9..1...28....7...5..1..851.....5....3.......3..68........21.....87")
		assert_raise(Exception) {Sudoku::Solver::Simple.new(grid)}
	end
	
	def test_invalid_duplicate_col
		grid = Sudoku::Grid.new("6.159.....9..1............4.7.314..6.24.....5..3....1...6.....3...9.2.4......16..")
		assert_raise(Exception) {Sudoku::Solver::Simple.new(grid)}
	end
	
	def test_invalid_duplicate_row
		grid = Sudoku::Grid.new(".4.1..35.............2.5......4.89..26.....12.5.3....7..4...16.6....7....1..8..2.")
		assert_raise(Exception) {Sudoku::Solver::Simple.new(grid)}
	end	
	
	def test_unsolvable_square
		grid = Sudoku::Grid.new("..9.287..8.6..4..5..3.....46.........2.71345.........23.....5..9..4..8.7..125.3..")	
		solver = Sudoku::Solver::Simple.new(grid)
		assert_equal(0, solver.solutions.length)	
	end

	def test_unsolvable_box
		grid = Sudoku::Grid.new(".9.3....1....8..46......8..4.5.6..3...32756...6..1.9.4..1......58..2....2....7.6.")	
		solver = Sudoku::Solver::Simple.new(grid)
		assert_equal(0, solver.solutions.length)	
	end
	
	def test_unsolvable_col
		grid = Sudoku::Grid.new("....41....6.....2...2......32.6.........5..417.......2......23..48......5.1..2...")	
		solver = Sudoku::Solver::Simple.new(grid)
		assert_equal(0, solver.solutions.length)	
	end	
	
	def test_unsolvable_row
		grid = Sudoku::Grid.new("9..1....4.14.3.8....3....9....7.8..18....3..........3..21....7...9.4.5..5...16..3")	
		solver = Sudoku::Solver::Simple.new(grid)
		assert_equal(0, solver.solutions.length)	
	end	
	
	def test_not_unique_two_solutions
		grid = Sudoku::Grid.new(".39...12....9.7...8..4.1..6.42...79...........91...54.5..1.9..3...8.5....14...87.")
		solver = Sudoku::Solver::Simple.new(grid)
		assert_equal(2, solver.solutions.length)	
	end

	def test_not_unique_three_solutions
		grid = Sudoku::Grid.new("..3.....6...98..2.9426..7..45...6............1.9.5.47.....25.4.6...785...........")
		solver = Sudoku::Solver::Simple.new(grid)
		assert_equal(3, solver.solutions.length)	
	end
	
	def test_not_unique_four_solutions
		grid = Sudoku::Grid.new("....9....6..4.7..8.4.812.3.7.......5..4...9..5..371..4.5..6..4.2.17.85.9.........")
		solver = Sudoku::Solver::Simple.new(grid)
		assert_equal(4, solver.solutions.length)	
	end	

	def test_not_unique_ten_solutions
		grid = Sudoku::Grid.new("59.....486.8...3.7...2.1.......4.....753.698.....9.......8.3...2.6...7.934.....65")
		solver = Sudoku::Solver::Simple.new(grid)
		assert_equal(10, solver.solutions.length)	
	end	

	def test_not_unique_one_hundred_and_twenty_five__solutions
		grid = Sudoku::Grid.new("...3165..8..5..1...1.89724.9.1.85.2....9.1....4.263..1.5.....1.1..4.9..2..61.8...")
		solver = Sudoku::Solver::Simple.new(grid)
		assert_equal(125, solver.solutions.length)	
	end	


end