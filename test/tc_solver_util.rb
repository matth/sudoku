require 'sudoko/grid'
require 'sudoko/solver/util'

class TestSolverUtil < Test::Unit::TestCase

	def test_not_enough_givens
		
		grid = Sudoko::Grid.new("........................................1........................................")
		assert_equal(false, Sudoko::Solver::Util.enough_givens?(grid))

		grid = Sudoko::Grid.new(".................................................................................")
		assert_equal(false, Sudoko::Solver::Util.enough_givens?(grid))

		grid = Sudoko::Grid.new("...........5....9...4....1.2....3.5....7.....438...2......9.....1.4...6..........")
		assert_equal(false, Sudoko::Solver::Util.enough_givens?(grid))
	
	end

end
