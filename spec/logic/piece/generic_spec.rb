describe Piece::Generic do
  context "#initialize" do
    it "should create an nil object" do
      p = Piece::Generic.new(x: 1, y: 0)

      p.up.should be_nil
      p.down.should be_nil
      p.left.should be_nil
      p.right.should be_nil
      p.type.should be_nil
      p.x.should be 1
      p.y.should be 0
    end

    it "should initialize an empty piece with surrounding pieces" do
      upper_piece = Piece::Generic.new
      lower_piece = Piece::Generic.new
      left_piece = Piece::Generic.new
      right_piece = Piece::Generic.new

      center_piece = Piece::Generic.new({
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
end
