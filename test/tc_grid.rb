require 'sudoko/grid'

class TestGrid < Test::Unit::TestCase
	
	def test_to_s
		grid_str = "974236158638591742125487936316754289742918563589362417867125394253649871491873625"
		grid = Sudoko::Grid.new(grid_str)
		assert_equal(grid_str, grid.to_s)
	end

	def test_valid_grid_str
		assert_nothing_raised {grid = Sudoko::Grid.new(get_grid_str)}
	end
	
	def test_invalid_grid_str
		assert_raise(Exception) {grid = Sudoko::Grid.new("helloworld")}
		assert_raise(Exception) {grid = Sudoko::Grid.new("abcdefghi.........123456789.........123456789.........123456789.........123456789")}
		assert_raise(Exception) {grid = Sudoko::Grid.new("12345678-.........123456789.........123456789.........123456789.........123456789")}		
		assert_raise(Exception) {grid = Sudoko::Grid.new("!@£$%^&*(.........123456789.........123456789.........123456789.........123456789")}				
	end
	
	def test_set
		grid = Sudoko::Grid.new(".................................................................................")
		grid.set(1,1, 3)
		assert_equal(3, grid.get_row(1)[0])
	end
	
	def test_get_row

		grid = Sudoko::Grid.new(get_grid_str)
		
		assert_equal("111111111", grid.get_row(1).join(""))
		assert_equal("222222222", grid.get_row(2).join(""))		
		assert_equal("333333333", grid.get_row(3).join(""))		
		assert_equal("444444444", grid.get_row(4).join(""))				
		assert_equal("555555555", grid.get_row(5).join(""))				
		assert_equal("666666666", grid.get_row(6).join(""))						
		assert_equal("777777777", grid.get_row(7).join(""))								
		assert_equal("888888888", grid.get_row(8).join(""))		
		assert_equal("999999999", grid.get_row(9).join(""))								
		
	end

	def test_get_col

		grid = Sudoko::Grid.new("123456789.........123456789.........123456789.........123456789.........123456789")

		(1..9).each {|i| 
			assert_equal(grid.get_col(i).join(""), "#{i.to_s}0#{i.to_s}0#{i.to_s}0#{i.to_s}0#{i.to_s}")
		}
		
	end
	
	def test_get_box_from_col_and_row
	
		grid = Sudoko::Grid.new("111222333111222333111222333444555666444555666444555666777888999777888999777888999")		
		
		assert_equal(grid.get_box_from_col_and_row(1, 1).join(""), "111111111")
		assert_equal(grid.get_box_from_col_and_row(4, 3).join(""), "222222222")
		assert_equal(grid.get_box_from_col_and_row(9, 2).join(""), "333333333")
		assert_equal(grid.get_box_from_col_and_row(1, 5).join(""), "444444444")
		assert_equal(grid.get_box_from_col_and_row(5, 4).join(""), "555555555")
		assert_equal(grid.get_box_from_col_and_row(8, 6).join(""), "666666666")
		assert_equal(grid.get_box_from_col_and_row(2, 8).join(""), "777777777")
		assert_equal(grid.get_box_from_col_and_row(6, 9).join(""), "888888888")
		assert_equal(grid.get_box_from_col_and_row(9, 7).join(""), "999999999")

	end
	
	def test_get_box
	
		grid = Sudoko::Grid.new("111222333111222333111222333444555666444555666444555666777888999777888999777888999")

		assert_equal(grid.get_box(1).join(""), "111111111")
		assert_equal(grid.get_box(2).join(""), "222222222")
		assert_equal(grid.get_box(3).join(""), "333333333")
		assert_equal(grid.get_box(4).join(""), "444444444")
		assert_equal(grid.get_box(5).join(""), "555555555")
		assert_equal(grid.get_box(6).join(""), "666666666")
		assert_equal(grid.get_box(7).join(""), "777777777")
		assert_equal(grid.get_box(8).join(""), "888888888")
		assert_equal(grid.get_box(9).join(""), "999999999")

	end
	
	def test_is_complete
		grid = Sudoko::Grid.new(get_grid_str)
		assert_equal(true, grid.is_complete)
		
		grid = Sudoko::Grid.new(get_grid_str.gsub(/[1]/, "."))
		assert_equal(false, grid.is_complete)
	end
	
	def test_is_valid

		# Duplicate box		
		grid = Sudoko::Grid.new("..9.7...5..21..9..1...28....7...5..1..851.....5....3.......3..68........21.....87")
		assert_equal(false, grid.is_valid)
		
		# Duplicate col
		grid = Sudoko::Grid.new("6.159.....9..1............4.7.314..6.24.....5..3....1...6.....3...9.2.4......16..")
		assert_equal(false, grid.is_valid)

		# Duplicate row
		grid = Sudoko::Grid.new(".4.1..35.............2.5......4.89..26.....12.5.3....7..4...16.6....7....1..8..2.")
		assert_equal(false, grid.is_valid)		
		
		grid = Sudoko::Grid.new("974236158638591742125487936316754289742918563589362417867125394253649871491873625")
		assert_equal(true, grid.is_valid)
		
		grid = Sudoko::Grid.new("9........8........7........6........5........4........3........2........1........")
		assert_equal(true, grid.is_valid)
		
	end
	
	def get_grid_str
		
		grid_str = ""	
		
		(1..9).each {|i|
			(1..9).each {|x| grid_str = grid_str + i.to_s}
		}
		
		return grid_str
	end

end