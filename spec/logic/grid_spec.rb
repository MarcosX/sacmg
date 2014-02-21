describe Grid do
  context "#initialize" do
    it "should create an array of pieces array" do
      g = Grid.new(width: 2, height: 2)

      g.pieces.each_with_index do |row, i|
        row.each_with_index do |piece, j|
          piece.should be_a Piece::Empty
          piece.x.should == i
          piece.y.should == j
        end
      end
    end
  end
end
