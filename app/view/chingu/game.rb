require_relative '../../game_helper'
require_relative '../../logic/piece'
require_relative '../../logic/grid'

class Game < Chingu::Window
  include Chingu::Helpers::GFX

  def initialize
    super
    self.input = {escape: :exit, left_mouse_button: :click}
    @mouse_clicked = 0
    @grid = Grid.new(width: 10, height: 10)
    @grid.pieces.each_with_index do |row, i|
      row.each_with_index do |piece, j|
        @grid.pieces[i][j] = piece.generate_random_piece
      end
    end
  end

  def draw
    @offset = ($window.width - @grid.width*Piece::WIDTH)/2
    cursor_x = ($window.mouse_x.to_i-@offset)/Piece::WIDTH
    cursor_y = $window.mouse_y.to_i/Piece::WIDTH
    fill_rect [cursor_x*Piece::WIDTH + @offset, cursor_y*Piece::WIDTH, Piece::WIDTH, Piece::WIDTH], Gosu::Color::WHITE

    if !@grid.current_piece_x.nil?
      fill_rect [@grid.current_piece_x*Piece::WIDTH + @offset, @grid.current_piece_y*Piece::WIDTH, Piece::WIDTH, Piece::WIDTH], Gosu::Color::WHITE
    end

    if !@grid.previous_piece_x.nil?
      fill_rect [@grid.previous_piece_x*Piece::WIDTH + @offset, @grid.previous_piece_y*Piece::WIDTH, Piece::WIDTH, Piece::WIDTH], Gosu::Color::WHITE
    end

    @grid.each_piece do |piece|
      x = piece.x * Piece::WIDTH + @offset
      y = piece.y * Piece::WIDTH
      color = map_piece_type(piece.type)
      fill_rect [x+2, y+2, Piece::WIDTH-4, Piece::WIDTH-4], color
    end
  end

  def click
    mouse_index_x = ($window.mouse_x.to_i-@offset)/Piece::WIDTH
    mouse_index_y = $window.mouse_y.to_i/Piece::WIDTH
    @grid.select_piece mouse_index_x, mouse_index_y
  end

  protected

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
