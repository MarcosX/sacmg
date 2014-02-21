describe Piece::Empty do

  context "#generate_random_piece" do
    it "should generate a random piece by default" do
      p = Piece::Empty.new
      p.stub(:random_type) { Piece::BLUE  }
      p = p.generate_random_piece

      p.should be_a Piece::Colored
      p.type.should be_equal Piece::BLUE
    end
  end

  context "#copy_from_upper_piece" do
    it "should generate a piece equal the upper piece, and turn the upper piece empty" do
      upper_piece = Piece::Colored.new(type: Piece::BLUE)
      empty_piece = Piece::Empty.new(up: upper_piece)

      empty_piece, upper_piece = empty_piece.copy_from_upper_piece upper_piece

      upper_piece.should be_a Piece::Empty
      empty_piece.should be_a Piece::Colored
      empty_piece.type.should be_equal Piece::BLUE
    end
  end
end
