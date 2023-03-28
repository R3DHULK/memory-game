# Define game loop
loop do
  # Generate shuffled deck of cards
  cards = ("A".."Z").to_a.sample(8) * 2
  cards.shuffle!

  # Initialize game board
  board = Array.new(4) { Array.new(4) { " " } }

  # Define method to print board
  def print_board(board)
    puts "  1 2 3 4"
    puts " +-+-+-+-+"
    board.each_with_index do |row, i|
      puts "#{i+1}|#{row.join('|')}|"
      puts " +-+-+-+-+"
    end
  end

  # Define method to prompt user for move
  def get_move
    print "Enter row and column (e.g. 2 3): "
    gets.chomp.split.map(&:to_i)
  end

  # Play game
  pairs_found = 0
  attempts = 0
  until pairs_found == 8
    print_board(board)
    first_row, first_col = get_move.map { |x| x - 1 }
    if board[first_row][first_col] != " "
      puts "Card already flipped over!"
      next
    end
    board[first_row][first_col] = cards[first_row*4 + first_col]
    print_board(board)
    second_row, second_col = get_move.map { |x| x - 1 }
    if board[second_row][second_col] != " "
      puts "Card already flipped over!"
      board[first_row][first_col] = " "
      next
    end
    board[second_row][second_col] = cards[second_row*4 + second_col]
    print_board(board)
    if board[first_row][first_col] == board[second_row][second_col]
      puts "Match found!"
      pairs_found += 1
    else
      puts "No match."
      board[first_row][first_col] = " "
      board[second_row][second_col] = " "
    end
    attempts += 1
  end

  # Print game summary
  puts "Congratulations, you won in #{attempts} attempts!"
  print "Play again? (y/n): "
  play_again = gets.chomp.downcase
  break if play_again == "n"
end
