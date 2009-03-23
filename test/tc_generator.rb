require 'sudoku/generator/full_grid_factory'

class TestGenerator < Test::Unit::TestCase

	def test_fill_grid
		
		(0..50).each{|k|		
			grid = Sudoku::Generator::FullGridFactory.create_grid
			assert_equal(true, grid.is_valid)
		}

	end
	
	def test_int_to_vertex
	
		num = 0
		matrix = [[],[],[],[],[],[],[],[],[]]
		
		(0..8).each{|i|
			(0..8).each{|j|
				matrix[i][j] = num
				num = num + 1
			}
		}
				
		(0..80).each{|i|
			
			col = Sudoku::Generator::FullGridFactory.int_to_vertex(i)[0]		
			row = Sudoku::Generator::FullGridFactory.int_to_vertex(i)[1]
			
			assert_equal(i, matrix[row][col])
			
		}
	
	end

end
