describe Piece::Empty do
  context "#initialize" do
    it "should create an nil object" do
      p = Piece::Empty.new

      p.up.should be_nil
      p.down.should be_nil
      p.left.should be_nil
      p.right.should be_nil
      p.type.should be_nil
    end

    it "should initialize an emty piece with surrounding pieces" do
      upper_piece = Piece::Empty.new
      lower_piece = Piece::Empty.new
      left_piece = Piece::Empty.new
      right_piece = Piece::Empty.new

      center_piece = Piece::Empty.new({
        up: upper_piece,
        down: lower_piece,
        left: left_piece,
        right: right_piece })

      center_piece.up.should be_equal upper_piece
      center_piece.down.should be_equal lower_piece
      center_piece.left.should be_equal left_piece
      center_piece.right.should be_equal right_piece
    end
  end

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
