require_relative "../../game_helper"

module Piece
  class Generic
    attr_accessor :up, :down, :left, :right, :type, :x, :y

    def initialize args = {}
      assign_upper_piece args[:up] unless args[:up].nil?
      assign_lower_piece args[:down] unless args[:down].nil?
      assign_left_piece args[:left] unless args[:left].nil?
      assign_right_piece args[:right] unless args[:right].nil?
      self.x, self.y = args[:x], args[:y]
    end

    protected
    def assign_upper_piece piece
      self.up = piece
      piece.down = self
    end

    def assign_lower_piece piece
      self.down = piece
      piece.up = self
    end

    def assign_left_piece piece
      self.left = piece
      piece.right = self
    end

    def assign_right_piece piece
      self.right = piece
      piece.left = self
    end
  end
end

