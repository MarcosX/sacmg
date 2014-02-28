require_relative "piece/empty"
require_relative "piece/colored"

class Grid
  attr_accessor :width, :height, :pieces, :current_piece_x, :current_piece_y, :previous_piece_x, :previous_piece_y

  def initialize args = {}
    self.width = args[:width]
    self.height = args[:height]
    self.pieces = Array.new

    (0..(height-1)).each do |y|
      self.pieces[y] = Array.new
      (0..(width-1)).each do |x|
        piece_params = {x: x, y: y}
        piece_params[:up] = self.pieces[y-1][x] if y > 0
        piece_params[:left] = self.pieces[y][x-1] if x > 0

        self.pieces[y] << Piece::Empty.new(piece_params)
      end
    end
  end

  def play_move from, to
    y_from, x_from = from
    y_to, x_to = to

    @pieces[y_from][x_from].type, @pieces[y_to][x_to].type = @pieces[y_to][x_to].type, @pieces[y_from][x_from].type
  end

  def select_piece y, x
    @previous_piece_x = @current_piece_x
    @previous_piece_y = @current_piece_y

    @current_piece_y, @current_piece_x = y, x

    if !@previous_piece_y.nil?
      if selected_pieces_are_neighbors?
        play_move [@current_piece_y, @current_piece_x], [@previous_piece_y, @previous_piece_x]
        find_matching_pieces_and_update_grid
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

  def find_matching_pieces_and_update_grid
    current_piece_matchings = self.pieces[@current_piece_y][@current_piece_x].find_matching_pieces
    previous_piece_matchings = self.pieces[@previous_piece_y][@previous_piece_x].find_matching_pieces
    matching_pieces = (current_piece_matchings + previous_piece_matchings).uniq

    if matching_pieces.size > 2
      matching_pieces.each do |match|
        piece_y, piece_x = match
        self.pieces[piece_y][piece_x] = self.pieces[piece_y][piece_x].generate_empty_piece
        if piece_y > 0
          self.pieces[piece_y][piece_x], self.pieces[piece_y-1][piece_x] =
            self.pieces[piece_y][piece_x].copy_from_upper_piece(self.pieces[piece_y-1][piece_x])
          next_piece_y = piece_y - 1
          while(next_piece_y > 0) do
            self.pieces[next_piece_y][piece_x], self.pieces[next_piece_y-1][piece_x] =
              self.pieces[next_piece_y][piece_x].copy_from_upper_piece(self.pieces[next_piece_y-1][piece_x])
            next_piece_y -= 1
          end
          self.pieces[next_piece_y][piece_x] = self.pieces[next_piece_y][piece_x].generate_safe_random_piece
        else
          self.pieces[piece_y][piece_x] = self.pieces[piece_y][piece_x].generate_safe_random_piece
        end
      end
    end
  end

  protected

  def selected_pieces_are_neighbors?
    (@current_piece_x - @previous_piece_x).abs  <= 1 && (@current_piece_y - @previous_piece_y).abs < 1 ||
      (@current_piece_y - @previous_piece_y).abs  <= 1 && (@current_piece_x - @previous_piece_x).abs < 1
  end
end
