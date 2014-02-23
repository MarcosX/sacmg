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

    def generate_safe_random_piece
      taken_types = Array.new
      taken_types << self.up.type unless self.up.nil?
      taken_types << self.down.type unless self.down.nil?
      taken_types << self.left.type unless self.left.nil?
      taken_types << self.right.type unless self.right.nil?
      taken_types = taken_types.sort.uniq

      Piece::Colored.new({
        up: self.up,
        down: self.down,
        left: self.left,
        right: self.right,
        type: random_type_excluding(taken_types),
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

    def random_type_excluding taken_types
      available_types = Piece::ALL_TYPES - taken_types
      available_types[rand(available_types.size)]
    end
  end
end
