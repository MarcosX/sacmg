require_relative "../logic/grid"

g = Grid.new(width: 10, height: 5)

g.pieces.each_with_index do |row, i|
  row.each_with_index do |piece, j|
    piece = piece.generate_random_piece
    print piece.type
  end
  puts ""
end
