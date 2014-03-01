require_relative '../../game_helper'
require_relative '../../logic/piece'
require_relative '../../logic/grid'

class Game < Chingu::Window
  include Chingu::Helpers::GFX

  def initialize
    super
    self.input = {escape: :exit, left_mouse_button: :click}
    @mouse_clicked = 0
    @animation_cycle = 0
    @grid = Grid.new(width: 10, height: 10)
    @grid.pieces.each_with_index do |row, i|
      row.each_with_index do |piece, j|
        @grid.pieces[i][j] = piece.generate_safe_random_piece
      end
    end
    @offset = ($window.width - @grid.width*Piece::WIDTH)/2
  end

  def draw
    highlight_cursor

    if @animation_cycle == 0
      if @grid.matching_pieces.size > 2
        @animation_cycle = 30
      end

    else
      @animation_cycle -= 1
      highlight_pieces @grid.matching_pieces
      if @animation_cycle == 0
        @grid.update_grid
        @grid.find_other_matching_pieces
      end
    end

    draw_all_pieces
  end

  def click
    return if @animation_cycle > 0
    mouse_index_x = ($window.mouse_x.to_i-@offset)/Piece::WIDTH
    mouse_index_y = $window.mouse_y.to_i/Piece::WIDTH
    @grid.select_piece mouse_index_y, mouse_index_x
  end

  protected
  def draw_all_pieces
    @grid.each_piece do |piece|
      x = piece.x * Piece::WIDTH + @offset
      y = piece.y * Piece::WIDTH
      color = map_piece_type(piece.type)
      fill_rect [x+2, y+2, Piece::WIDTH-4, Piece::WIDTH-4], color
    end
  end

  def highlight_cursor
    cursor_x = ($window.mouse_x.to_i-@offset)/Piece::WIDTH
    cursor_y = $window.mouse_y.to_i/Piece::WIDTH
    if ($window.mouse_x > @offset) && ($window.mouse_x < ($window.width - @offset))
      fill_rect [cursor_x*Piece::WIDTH + @offset, cursor_y*Piece::WIDTH, Piece::WIDTH, Piece::WIDTH], Gosu::Color::WHITE
    end

    if !@grid.current_piece_x.nil?
      fill_rect [@grid.current_piece_x*Piece::WIDTH + @offset, @grid.current_piece_y*Piece::WIDTH, Piece::WIDTH, Piece::WIDTH], Gosu::Color::WHITE
    end
    if !@grid.previous_piece_x.nil?
      fill_rect [@grid.previous_piece_x*Piece::WIDTH + @offset, @grid.previous_piece_y*Piece::WIDTH, Piece::WIDTH, Piece::WIDTH], Gosu::Color::WHITE
    end
  end

  def highlight_pieces pieces
    puts pieces.inspect
    pieces.each do |piece|
      piece_y, piece_x = piece
      fill_rect [piece_x*Piece::WIDTH + @offset, piece_y*Piece::WIDTH, Piece::WIDTH, Piece::WIDTH], Gosu::Color::WHITE
    end
  end

  def map_piece_type type
    case type
    when Piece::BLUE then Gosu::Color::BLUE
    when Piece::RED then Gosu::Color::RED
    when Piece::GREEN then Gosu::Color::GREEN
    when Piece::YELLOW then Gosu::Color::YELLOW
    when Piece::FUCHSIA then Gosu::Color::FUCHSIA
    end
  end
end

Game.new.show
