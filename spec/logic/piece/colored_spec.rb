require_relative "../../spec_helper"

describe Piece::Colored do
  context "#initialize" do
    it "should have a color as type" do
      p = Piece::Colored.new(type: Piece::BLUE)

      p.type.should be_equal Piece::BLUE
    end
  end
end
