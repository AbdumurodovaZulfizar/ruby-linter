class Board
  attr_reader :sets, :grid
  attr_accessor :selections

  def initialize
    @sets = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]]
    @grid = "+---+---+---+\n| 1 | 2 | 3 |\n+---+---+---+\n| 4 | 5 | 6 |\n+---+---+---+\n| 7 | 8 | 9 |\n+---+---+---+"
    @selections = []
  end

  def insert(number, sym)
    @grid[@grid.index(number.to_s)] = sym
  end
end
