require_relative "generic"

module Piece
  class Colored < Generic
    def initialize args = {}
      super args
      self.type = args[:type]
    end
  end
end
