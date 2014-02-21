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
        type: random_type
      })
    end

    def copy_from_upper_piece upper_piece
      new_piece = Piece::Colored.new({
        up: self.up,
        down: self.down,
        left: self.left,
        right: self.right,
        type: self.up.type
      })
      new_up = Piece::Empty.new({
        up: upper_piece.up,
        down: upper_piece.down,
        left: upper_piece.left,
        right: upper_piece.right
      })
      [new_piece, new_up]
    end

    protected
    def random_type
      Piece::ALL_TYPES[rand(Piece::ALL_TYPES.size)]
    end
  end
end
