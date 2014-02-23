require_relative "piece/empty"
require_relative "piece/colored"

class Grid
  attr_accessor :width, :height, :pieces, :current_piece_x, :current_piece_y, :previous_piece_x, :previous_piece_y

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
    y_from, x_from = from
    y_to, x_to = to

    @pieces[y_from][x_from].type, @pieces[y_to][x_to].type = @pieces[y_to][x_to].type, @pieces[y_from][x_from].type
  end

  def select_piece x, y
    @previous_piece_x = @current_piece_x
    @previous_piece_y = @current_piece_y

    @current_piece_x, @current_piece_y = x, y

    if !@previous_piece_y.nil?
      if (@current_piece_x - @previous_piece_x).abs  <= 1 && (@current_piece_y - @previous_piece_y).abs < 1 ||
        (@current_piece_y - @previous_piece_y).abs  <= 1 && (@current_piece_x - @previous_piece_x).abs < 1
          play_move [@current_piece_x, @current_piece_y], [@previous_piece_x, @previous_piece_y]
          @current_piece_x = @current_piece_y = nil
      end
      @previous_piece_x = @previous_piece_y = nil
    end
  end

  def each_piece
    self.pieces.each do |row|
      row.each do |piece|
        yield piece
      end
    end
  end
end
