module Sudoku
	module Solver

		# This holds some generic utility methods for solving sudoku puzzles
		# 
		# Copyright (c) 2009 Matt Haynes
		# 
		# This program is free software: you can redistribute it and/or modify
		# it under the terms of the GNU General Public License as published by
		# the Free Software Foundation, either version 3 of the License, or
		# (at your option) any later version.
		# 
		# This program is distributed in the hope that it will be useful,
		# but WITHOUT ANY WARRANTY; without even the implied warranty of
		# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
		# GNU General Public License for more details.
		# 
		# You should have received a copy of the GNU General Public License
		# along with this program.  If not, see <http://www.gnu.org/licenses/>
		#	
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