require_relative "../piece"
require_relative "generic"
require_relative "colored"

module Piece
  class Empty < Generic
    def generate_random_piece
      Piece::Colored.new({
        up: self.up,
        down: self.down,
        left: self.left,
        right: self.right,
        type: random_type,
        x: self.x,
        y: self.y
      })
    end

    def assign_color_to_piece color
      Piece::Colored.new({
        up: self.up,
        down: self.down,
        left: self.left,
        right: self.right,
        type: color,
        x: self.x,
        y: self.y
      })
    end

    def copy_from_upper_piece upper_piece
      new_piece = Piece::Colored.new({
        up: self.up,
        down: self.down,
        left: self.left,
        right: self.right,
        type: self.up.type,
        x: self.x,
        y: self.y
      })
      new_up = Piece::Empty.new({
        up: upper_piece.up,
        down: upper_piece.down,
        left: upper_piece.left,
        right: upper_piece.right,
        x: upper_piece.x,
        y: upper_piece.y
      })
      [new_piece, new_up]
    end

    protected
    def random_type
      Piece::ALL_TYPES[rand(Piece::ALL_TYPES.size)]
    end
  end
end
