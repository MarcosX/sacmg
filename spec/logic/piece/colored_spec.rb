describe Piece::Colored do
  context "#initialize" do
    it "should have a color as type" do
      p = Piece::Colored.new(type: Piece::BLUE)

      p.type.should be_equal Piece::BLUE
    end
  end

  context "#find_matching_pieces" do
    it "should return all pieces matching the color horizontally" do
      p1 = Piece::Colored.new(x:0, y:0, type: Piece::RED)
      p2 = Piece::Colored.new(x:1, y:0, type: Piece::RED, left: p1)
      Piece::Colored.new(x:2, y:0, type: Piece::RED, left: p2)

      p2.find_matching_pieces.should =~ [[0,0], [0,1], [0,2]]
    end

    it "should return all pieces matching the color vertically" do
      p1 = Piece::Colored.new(x:0, y:0, type: Piece::RED)
      p2 = Piece::Colored.new(x:0, y:1, type: Piece::RED, down: p1)
      Piece::Colored.new(x:0, y:2, type: Piece::RED, down: p2)

      p2.find_matching_pieces.should =~ [[0,0], [1,0], [2,0]]
    end
  end

  context "#generate_empty_piece" do
    it "should create an empty piece with the same attributes but no type" do
      p = Piece::Colored.new(x:0, y:0, type: Piece::RED)
      p = p.generate_empty_piece

      p.type.should be_nil
      p.should be_a Piece::Empty
      p.x.should == 0
      p.y.should == 0
    end
  end
end
