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
      g.pieces[0][0] = g.pieces[0][0].assign_color_to_piece Piece::BLUE
      g.pieces[0][1] = g.pieces[0][1].assign_color_to_piece Piece::RED

      g.play_move [0,0], [0,1]

      g.pieces[0][0].type.should be_equal Piece::RED
      g.pieces[0][1].type.should be_equal Piece::BLUE
    end
  end
end
