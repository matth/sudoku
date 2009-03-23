module Sudoku
	module Generator
		#
		# Utility class for generating a valid completed sudoku solution, this just
		# uses a fairly simpistic brute-force back tarcing algorithm
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