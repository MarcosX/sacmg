describe Piece::Empty do

  context "#generate_random_piece" do
    it "should generate a random piece" do
      p = Piece::Empty.new(x: 1, y: 0)
      p.stub(:random_type) { Piece::BLUE  }
      p = p.generate_random_piece

      p.should be_a Piece::Colored
      p.type.should be_equal Piece::BLUE
      p.x.should == 1
      p.y.should == 0
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

  context "#assign_color_to_piece" do
    it "should create a piece with same attributes and given color" do
      p = Piece::Empty.new(x: 1, y: 0)
      p = p.assign_color_to_piece Piece::BLUE

      p.should be_a Piece::Colored
      p.type.should be_equal Piece::BLUE
      p.x.should == 1
      p.y.should == 0
    end
  end
end
