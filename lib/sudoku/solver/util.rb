module Sudoku
	module Solver

		# This holds some generic utility methods for solving sudoku puzzles
		class Util
		
			# Check that a grid has enough givens to be completed.
			# 17 is accepted minimum number for a classic Sudoku puzzle
			def self.enough_givens?(grid)
				grid.to_s.split("").delete_if{|v| v == "."}.length > 16 
			end		
		
			# Get array of all possible canidates for a square
			def self.get_candidates(grid, col, row)
				
				candidates = []
				
				already_set = [grid.get_row(row), grid.get_col(col), grid.get_box_from_col_and_row(col, row)].flatten
				
				(1..9).each{|c|
					candidates.push(c) unless already_set.include?(c)
				}
					
				candidates
			end					
		
		end
		
	end
end