require_relative "generic"

module Piece
  class Colored < Generic
    def initialize args = {}
      super args
      self.type = args[:type]
    end

    def generate_empty_piece
      Piece::Empty.new({
        up: self.up,
        down: self.down,
        left: self.left,
        right: self.right,
        x: self.x,
        y: self.y
      })
    end

    def find_matching_pieces
      horizontal_matches = [[self.y, self.x]]
      vertical_matches = [[self.y, self.x]]

      piece = self.left
      while(!piece.nil? && piece.type == self.type) do
        horizontal_matches << [piece.y, piece.x]
        piece = piece.left
      end

      piece = self.right
      while(!piece.nil? && piece.type == self.type) do
        horizontal_matches << [piece.y, piece.x]
        piece = piece.right
      end

      piece = self.up
      while(!piece.nil? && piece.type == self.type) do
        horizontal_matches << [piece.y, piece.x]
        piece = piece.up
      end

      piece = self.down
      while(!piece.nil? && piece.type == self.type) do
        horizontal_matches << [piece.y, piece.x]
        piece = piece.down
      end

      (horizontal_matches + vertical_matches).uniq
    end
  end
end
