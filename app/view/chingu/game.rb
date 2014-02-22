require_relative '../../game_helper'
require_relative '../../logic/piece'
require_relative '../../logic/grid'

class Game < Chingu::Window
  include Chingu::Helpers::GFX

  def initialize
    super
    self.input = {escape: :exit, left_mouse_button: :click}
    @w = 60
    @mouse_clicked = 0
    @grid = Grid.new(width: 10, height: 10)
    @grid.pieces.each_with_index do |row, i|
      row.each_with_index do |piece, j|
        @grid.pieces[i][j] = piece.generate_random_piece
      end
    end
  end

  def draw
    @offset = ($window.width - @grid.width*@w)/2
    cursor_x = ($window.mouse_x.to_i-@offset)/@w
    cursor_y = $window.mouse_y.to_i/@w
    fill_rect [cursor_x*@w + @offset, cursor_y*@w, @w, @w], Gosu::Color::WHITE

    if @mouse_clicked > 0
      fill_rect [@mouse_x*@w + @offset, @mouse_y*@w, @w, @w], Gosu::Color::WHITE
      if @mouse_clicked > 1
        @mouse_clicked = 0
        if (@previous_mouse_x - @mouse_x).abs <= 1 && (@previous_mouse_y - @mouse_y).abs < 1 ||
          (@previous_mouse_y - @mouse_y).abs <= 1 && (@previous_mouse_x - @mouse_x).abs < 1
            @grid.play_move [@previous_mouse_y, @previous_mouse_x], [@mouse_y, @mouse_x]
        else
          @mouse_clicked = 1
        end
      end
    end

    @grid.each_piece do |piece|
      x = piece.x * @w + @offset
      y = piece.y * @w
      color = map_piece_type(piece.type)
      fill_rect [x+2, y+2, @w-4, @w-4], color
    end
  end

  def click
    @previous_mouse_x = @mouse_x
    @previous_mouse_y = @mouse_y
    @mouse_x = ($window.mouse_x.to_i-@offset)/@w
    @mouse_y = $window.mouse_y.to_i/@w
    @mouse_clicked += 1
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
