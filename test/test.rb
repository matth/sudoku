# Test runner script

$:.unshift File.join(File.dirname(__FILE__), "..", "lib")
$:.unshift File.dirname(__FILE__)

require 'test/unit'
require 'pp'
require 'tc_generator'
require 'tc_grid'
require 'tc_solver_simple'
require 'tc_solver_util'
require 'sudoku'