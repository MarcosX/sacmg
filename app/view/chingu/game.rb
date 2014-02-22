require_relative '../../game_helper'
require_relative '../../logic/piece'
require_relative '../../logic/grid'

class Game < Chingu::Window
  include Chingu::Helpers::GFX

  def initialize
    super
    self.input = {escape: :exit}
    @grid = Grid.new(width: 10, height: 10)
    @grid.pieces.each_with_index do |row, i|
      row.each_with_index do |piece, j|
        @grid.pieces[i][j] = piece.generate_random_piece
      end
    end
  end

  def draw
    @grid.each_piece do |piece|
      w = 60
      x = piece.x * w
      y = piece.y * w
      color = map_piece_type(piece.type)
      fill_rect [x+2, y+2, w-2, w-2], color
    end
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
