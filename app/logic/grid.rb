require_relative "piece/empty"
require_relative "piece/colored"

class Grid
  attr_accessor :width, :height, :pieces

  def initialize args = {}
    self.width = args[:width]
    self.height = args[:height]
    self.pieces = Array.new

    (0..(height-1)).each do |i|
      self.pieces[i] = Array.new
      (0..(width-1)).each do |j|
        self.pieces[i] << Piece::Empty.new(x: j, y: i)
      end
    end
  end

  def play_move from, to
    x_from, y_from = from
    x_to, y_to = to

    pieces[x_from][y_from].type, pieces[x_to][y_to].type = pieces[x_to][y_to].type, pieces[x_from][y_from].type
  end
end
