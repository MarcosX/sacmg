describe Grid do
  context "#initialize" do
    it "should create an array of pieces array" do
      g = Grid.new(width: 2, height: 2)

      g.pieces.each_with_index do |row, i|
        row.each_with_index do |piece, j|
          piece.should be_a Piece::Empty
          piece.x.should == j
          piece.y.should == i
        end
      end
    end
  end

  context "#play_move" do
    it "should swap the type of the two pieces" do
      g = Grid.new(width: 2, height: 1)
      g.pieces[0][0] = Piece::Colored
    end
  end
end
