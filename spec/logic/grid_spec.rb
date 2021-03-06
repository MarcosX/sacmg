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

    it "should create pieces with neighbors" do
      g = Grid.new(width: 2, height: 2)

      g.pieces[0][0].right.should be_equal g.pieces[0][1]
      g.pieces[0][0].down.should be_equal g.pieces[1][0]

      g.pieces[1][0].right.should be_equal g.pieces[1][1]
      g.pieces[1][0].up.should be_equal g.pieces[0][0]

      g.pieces[0][1].left.should be_equal g.pieces[0][0]
      g.pieces[0][1].down.should be_equal g.pieces[1][1]

      g.pieces[1][1].up.should be_equal g.pieces[0][1]
      g.pieces[1][1].left.should be_equal g.pieces[1][0]
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

  context "#each_piece" do
    it "should return each piece" do
      g = Grid.new(width: 2, height: 2)
      pieces = Array.new
      g.each_piece do |piece|
        pieces << piece
      end
      pieces.size.should == 4
    end
  end

  context "#select_piece" do
    it "should save the position of the selected piece" do
      g = Grid.new(width: 2, height: 1)
      g.select_piece(0, 1)

      g.current_piece_x.should == 1
      g.current_piece_y.should == 0
    end

    it "should swap pieces if the move is only one piece away and unselect pieces" do
      g = Grid.new(width: 2, height: 1)
      g.pieces[0][0] = g.pieces[0][0].assign_color_to_piece Piece::BLUE
      g.pieces[0][1] = g.pieces[0][1].assign_color_to_piece Piece::RED

      g.select_piece(0, 1)
      g.select_piece(0, 0)

      g.current_piece_x.should be_nil
      g.current_piece_y.should be_nil
      g.previous_piece_x.should be_nil
      g.previous_piece_y.should be_nil
      g.pieces[0][0].type.should be_equal Piece::RED
      g.pieces[0][1].type.should be_equal Piece::BLUE
    end

    it "should not swap pieces if the move is more than one piece away and clean previous piece selection" do
      g = Grid.new(width: 2, height: 2)
      g.pieces[0][0] = g.pieces[0][0].assign_color_to_piece Piece::BLUE
      g.pieces[0][1] = g.pieces[0][1].assign_color_to_piece Piece::RED
      g.pieces[1][1] = g.pieces[1][1].assign_color_to_piece Piece::YELLOW

      g.select_piece(0, 0)
      g.select_piece(1, 1)

      g.current_piece_x.should == 1
      g.current_piece_y.should == 1
      g.previous_piece_x.should be_nil
      g.previous_piece_y.should be_nil
    end
  end

  context "#find_matching_pieces" do
    it "should return an empty array if the total of matches is lower than 3" do
      g = Grid.new(width: 3, height: 1)
      g.pieces[0][0] = g.pieces[0][0].assign_color_to_piece Piece::RED
      g.pieces[0][1] = g.pieces[0][1].assign_color_to_piece Piece::RED
      g.pieces[0][2] = g.pieces[0][2].assign_color_to_piece Piece::BLUE

      g.previous_piece_y, g.previous_piece_x = 0, 0
      g.current_piece_y, g.current_piece_x = 0, 1
      g.find_matching_pieces

      g.matching_pieces.should be_empty
    end

    it "should return the matches if the total of matches is higher than 2" do
      g = Grid.new(width: 3, height: 1)
      g.pieces[0][0] = g.pieces[0][0].assign_color_to_piece Piece::RED
      g.pieces[0][1] = g.pieces[0][1].assign_color_to_piece Piece::RED
      g.pieces[0][2] = g.pieces[0][2].assign_color_to_piece Piece::RED

      g.previous_piece_y, g.previous_piece_x = 0, 0
      g.current_piece_y, g.current_piece_x = 0, 1
      g.find_matching_pieces

      g.matching_pieces.should include [0,0]
      g.matching_pieces.should include [0,1]
      g.matching_pieces.should include [0,2]
    end
  end

  context "#update_grid" do
    it "should make matching colors empty and copy the upper piece type" do
      g = Grid.new(width: 3, height: 2)
      g.pieces[0][0] = g.pieces[0][0].assign_color_to_piece Piece::FUCHSIA
      g.pieces[0][1] = g.pieces[0][1].assign_color_to_piece Piece::YELLOW
      g.pieces[0][2] = g.pieces[0][2].assign_color_to_piece Piece::BLUE

      g.pieces[1][0] = g.pieces[1][0].assign_color_to_piece Piece::RED
      g.pieces[1][1] = g.pieces[1][1].assign_color_to_piece Piece::RED
      g.pieces[1][2] = g.pieces[1][2].assign_color_to_piece Piece::RED

      g.matching_pieces = [[1,0], [1,1], [1,2]]
      g.update_grid

      g.pieces[1][0].type.should be_equal Piece::FUCHSIA
      g.pieces[1][1].type.should be_equal Piece::YELLOW
      g.pieces[1][2].type.should be_equal Piece::BLUE
    end
  end

  context "#find_other_matching_pieces" do
    it "should return an array with all matching pieces in the current grid" do
      g = Grid.new(width: 3, height: 3)
      g.pieces[0][0] = g.pieces[0][0].assign_color_to_piece Piece::FUCHSIA
      g.pieces[0][1] = g.pieces[0][1].assign_color_to_piece Piece::RED
      g.pieces[0][2] = g.pieces[0][2].assign_color_to_piece Piece::BLUE

      g.pieces[1][0] = g.pieces[1][0].assign_color_to_piece Piece::RED
      g.pieces[1][1] = g.pieces[1][1].assign_color_to_piece Piece::RED
      g.pieces[1][2] = g.pieces[1][2].assign_color_to_piece Piece::RED

      g.pieces[2][0] = g.pieces[2][0].assign_color_to_piece Piece::FUCHSIA
      g.pieces[2][1] = g.pieces[2][1].assign_color_to_piece Piece::RED
      g.pieces[2][2] = g.pieces[2][2].assign_color_to_piece Piece::BLUE

      g.find_other_matching_pieces

      g.matching_pieces.should include [0,1]
      g.matching_pieces.should include [1,0]
      g.matching_pieces.should include [1,1]
      g.matching_pieces.should include [1,2]
      g.matching_pieces.should include [2,1]
    end
  end
end
