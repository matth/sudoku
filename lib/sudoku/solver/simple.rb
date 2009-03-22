require 'sudoku/grid'
require 'sudoku/solver/util'

module Sudoku
	module Solver

		# This is a pretty simplistic brute-force backtracing algorithm, it's based
		# upon the example at http://en.wikipedia.org/wiki/Algorithmics_of_sudoku
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
		class Simple
		
			attr_accessor :solutions
		
			def initialize(grid)
				
				@solutions = []
				
				if (!Sudoku::Solver::Util::enough_givens?(grid))
					raise Exception.new("Not enough givens to solve this puzzle")
				end

				if (!grid.is_valid)
					raise Exception.new("Grid is not valid, duplicate entries found")
				end
				
				solve(grid)
				
			end
			
			private
		
			def solve(grid)
								
				while true
				
					options = []
					
					(0..8).each { |i|
						(0..8).each { |j|
							next if grid.get_col(i + 1)[j] != 0
							
							c = Sudoku::Solver::Util.get_candidates(grid, i + 1, j + 1)
							
							# If nothing is permissible, there is no solution at this level.
							return false if (c.length == 0)
							
							options.push({:i => i, :j => j, :candidates => c})
						}
					}
					
					# If the matrix is complete, we have a solution...
					if options.length == 0
						@solutions.push(grid)
						return false 
					end
			 
					omin = options.min {| a, b |
						a[:candidates].length <=> b[:candidates].length
					}
		
					# If there is an option with only one solution, set it and re-check permissibility
					if omin[:candidates].length == 1
						grid.set(omin[:i] + 1, omin[:j] + 1, omin[:candidates][0])
						next
					end
			 
					# We have two or more choices. We need to search both...
					omin[:candidates].each {|v|
						mtmp = Sudoku::Grid.new(grid.to_s)
						mtmp.set(omin[:i] + 1, omin[:j] + 1, v)
						ret = solve(mtmp)
						if ret != false
							@solutions.push(ret)
						end
					}
			 
					# We did an exhaustive search on this branch and nothing worked out.
					return false
			 
			  	end
			 
			end
			
		end		
		
	end
end