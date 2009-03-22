module Sudoku
#
# This class represents a sudoku grid with helper methods for getting
# rows, columns and boxes, setting methods, testing for completness and 
# validity.
# 
# Copyright (c) 2009 Matt Haynes
# 
# Written and maintained by Matt Haynes <matt@matthaynes.net>.
#
# This program is free software. You can re-distribute and/or
# modify this program under the same terms of ruby itself ---
# Ruby Distribution License or GNU General Public License.
#

class Grid

	# Sudoku grid object
	#
	# Takes a string as a parameter, this is the conventional 81 character string representation
	# of a sudoku puzzle. Empty squares can be represented by either a "." or "0"
	#
	# Example:
	#
	#	require 'sudoku/grid'
	# 	
	# 	grid = Sudoku::Grid.new("..2.3...8.....8....31.2.....6..5.27..1.....5.2.4.6..31....8.6.5.......13..531.4..")
	#
	# or 
	#
	#   grid = Sudoku::Grid.new("002030008000008000031020000060050270010000050204060031000080605000000013005310400")
	#		
	def initialize(grid_str)
	
		if (grid_str =~ /[^1234567890\.]/) 
			raise Exception.new("grid_str may only contain characters 0123456789.")				
		end 
		
		if (grid_str.length != 81) 
			raise Exception.new("grid_str is not the correct size, must have exactly 81 characters")	
		end 
		
		@matrix	= [[],[],[],[],[],[],[],[],[]]
		
		i = 0
		
		grid_str.split("").each{|v|
			if (v == ".") 
				v = "0"
			end
			@matrix[row = (i / 9).floor].push(v.to_i)
			i = i + 1
		}
		
	end 
	
	# Output grid object as a string, this is the conventional 81 character representation
	# of a sudoku puzzle, using the character "." for empty squares
	def to_s
		@matrix.flatten.join.gsub(/0/, '.')
	end
		
	# "Pretty print" the sudoku grid as a string
	#
	# Example output:
	#
	#	+-----------------------+
	#	| . . 2 | . 3 . | . . 8 |
	# 	| . . . | . . 8 | . . . |
	# 	| . 3 1 | . 2 . | . . . |
	# 	|-------+-------+-------|
	# 	| . 6 . | . 5 . | 2 7 . |
	# 	| . 1 . | . . . | . 5 . |
	# 	| 2 . 4 | . 6 . | . 3 1 |
	# 	|-------+-------+-------|
	# 	| . . . | . 8 . | 6 . 5 |
	# 	| . . . | . . . | . 1 3 |
	# 	| . . 5 | 3 1 . | 4 . . |
	# 	+-----------------------+
	#
	def pretty_print
		
		pretty_str = "\n +-----------------------+"

		@matrix.each_index{ |i|
			
			pretty_str += "\n |"
			
			v = @matrix[i]
			
			v.each_index{|j|
					
				if (v[j] != 0)
					pretty_str += " " + v[j].to_s
				else 
					pretty_str += " ."
				end
				
				if (j == 2 || j == 5 || j == 8)
					pretty_str += " |"
				end
				
			}
			
			if (i == 2 || i == 5)
				pretty_str += "\n |-------+-------+-------|"		
			end			
	
		}

		pretty_str += "\n +-----------------------+"		
		
	end
	
	# Set the value for a vertices in the grid
	def set(col, row, value)
		@matrix[row - 1][col - 1] = value
	end		
	
	# Test if the grid has any empty squares 
	def is_complete
		!self.to_s.include? "."
	end
	
	# Test the grid is valid. This will check that each row, column and
	# box has no duplicates in. Note, this will not check that the solution 
	# is unique or that the puzzle is symetrical which are popularly seen as 
	# criteria for a valid sudoku
	def is_valid
		
		(1..9).each {|i|
			col = get_col(i).delete_if{|item| item == 0 }
			row = get_row(i).delete_if{|item| item == 0 }
			box = get_box(i).delete_if{|item| item == 0 }
			

			if ((!col.empty? && col.uniq! != nil) ||
				(!row.empty? && row.uniq! != nil) ||
				(!box.empty? && box.uniq! != nil))
				
				return false
			end

		}
		
		true
		
	end
	
	# Fetch one of the 3x3 boxes from the grid. These are numbered 1-9 from 
	# the top left across. Returns array.
	#
	# Example:
	#
	#	+---+---+---+
	#	| 1 | 2 | 3 |
	#	+---+---+---+
	#	| 4 | 5 | 6 |
	#	+---+---+---+
	#	| 7 | 8 | 9 |
	#	+---+---+---+		
	#
	#	grid.get_box(1)
	#
	def get_box(box)
		
		case (box % 3)
			when 1
				start_col = 1
			when 2
				start_col = 4
			when 0
				start_col = 7			
		end
				
		case box
			when 1,2,3
				start_row = 1
			when 4,5,6
				start_row = 4
			when 7,8,9
				start_row = 7			
		end
		
		values = []
		
		(0..2).each {|v|
			values.push(get_row(start_row + v).fetch(start_col - 1))
			values.push(get_row(start_row + v).fetch(start_col))
			values.push(get_row(start_row + v).fetch(start_col + 1))
		}
		
		values
		
	end
	
	# Get a box from the intersection between a column and row
	def get_box_from_col_and_row(col, row)
		
		col_offset = ((col - 1) / 3).ceil
		row_offset = ((row - 1) / 3).ceil
		
		if (col_offset == 0) 
			if (row_offset == 0)
				return get_box(1)
			end
			if (row_offset == 1)
				return get_box(4)
			end
			if (row_offset == 2)
				return get_box(7)
			end		
		end
		
		if (col_offset == 1) 
			if (row_offset == 0)
				return get_box(2)
			end
			if (row_offset == 1)
				return get_box(5)
			end
			if (row_offset == 2)
				return get_box(8)
			end		
		end		
		
		if (col_offset == 2) 
			if (row_offset == 0)
				return get_box(3)
			end
			if (row_offset == 1)
				return get_box(6)
			end
			if (row_offset == 2)
				return get_box(9)
			end		
		end				
		
	end
	
	# Get a row, numbered 1-9. Returns array.
	def get_row(row)
		Array.new(@matrix[row - 1])
	end

	# Get a column, numbered 1-9. Returns array.		
	def get_col(col)

		col_arr = []
		
		@matrix.each{|v| col_arr.push(v[col - 1]) }

		col_arr

	end

end
		
end