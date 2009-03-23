require 'sudoku/grid'
require 'sudoku/solver/util'

module Sudoku
	module Generator
		#
		# Utility class for generating a valid completed sudoku solution, this just
		# uses a fairly simpistic brute-force back tarcing algorithm
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
		class FullGridFactory
				
			def self.create_grid
				@@grid = Grid.new(".................................................................................")
				self.fill(0)
				@@grid
			end
			
			def self.fill(i)

				return true if (i == 81) 

				col = self.int_to_vertex(i)[0] 
				row = self.int_to_vertex(i)[1]
					
				candidates = Sudoku::Solver::Util.get_candidates(@@grid, col + 1, row + 1)
				
				while (!candidates.empty?)
							
					candidate_index = rand(candidates.length - 1).floor

					@@grid.set(col + 1, row + 1, candidates[candidate_index])
					
					if (self.fill(i + 1) == true)
						return true
					end
				
					candidates.delete_at(candidate_index)
					
					@@grid.set(col + 1, row + 1, 0)
				
				end

				return false
				
			end
			
			def self.int_to_vertex(int)
				row = (int / 9).ceil
				col = int % 9 
				[col, row]
			end
			
		end
				
	end
end