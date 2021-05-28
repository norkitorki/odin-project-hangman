# hangman input
module HangmanInput
  def input
    print "\n–> "
    gets.chomp.downcase
  end

  def mode_input
    puts 'Would you like to load a previously saved game or start a new one?' \
           "\n\n1 - to start a new game\n2 - to load a saved game"

    mode = input until ('1'..'3').include?(mode)
    mode
  end

  def guess_input(hidden_word)
    puts "\nPlease input your guess or 'save' to save your progress:"

    guess = ''
    guess = input until !hidden_word.include?(guess) && guess.match(/^\D+$/i)
    guess
  end

  def load_input(files)
    files.each_with_index { |filename, i| puts "\n#{i + 1} - #{filename}" }

    puts "\nPlease choose a saved game to load (#{1..files.length})"
    index = input.to_i until (1..files.length).include?(index)
    index - 1
  end

  def replay_input
    puts "\nWould you like to play again? (y/n)"

    replay = input until %w[y n].include?(replay)
    replay
  end
end
