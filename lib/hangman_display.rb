# hangman console content display
module HangmanDisplay
  def instructions
    <<~INSTRUCTIONS

      \e[4;39;49mWelcome to Hangman!\e[0m

      In this game the Computer will select a word between 5 and 12 characters in length and you will have to guess the word
      before the hangman is fully drawn.The hidden secret word will be displayed to you in the following way:

      #{word_display('       ')}

      In this example,we are looking for a word that is 7 characters long.
      Correct guesses will be appended,while incorrect guesses will be displayed in \e[0;31;49mred\e[0m.

      You have the option to input either single letters(\e[0;32;49ma-z\e[0m),or you can try to solve the whole word if you think that you might have guessed it.

      At each guess you will have the option to save your current game progress to resume the game at a later point in time.
      To save your progress,input \e[0;32;49msave\e[0m into the console when prompted for a guess.

    INSTRUCTIONS
  end

  def word_display(string)
    line   = Array.new(string.length, '━━━')
    word   = string.chars.join(' │ ')

    "┏#{line.join('┯')}┓\n┃ #{word} ┃\n┗#{line.join('┷')}┛"
  end

  def display_hangman(line_number)
    send("hangman_line#{line_number}") if line_number.between?(1, 10)
  end

  def display_mismatches(mismatches)
    "\n \e[0;31;49m#{mismatches.join('  ')}\e[0m\n\n" if mismatches.first
  end

  def hangman_line1
    '━━━━━━━'
  end

  def hangman_line2
    "       ┃\n       ┃\n       ┃\n       ┃\n       ┃\n       ┃\n━━━━━━━┛\n"
  end

  def hangman_line3
    "  ━━━━━┓\n       ┃\n       ┃\n       ┃\n       ┃\n       ┃\n       ┃\n" \
    "━━━━━━━┛\n"
  end

  def hangman_line4
    "  ┏━━━━┓\n  │    ┃\n       ┃\n       ┃\n       ┃\n       ┃\n       ┃\n" \
    "━━━━━━━┛\n"
  end

  def hangman_line5
    "  ┏━━━━┓\n  │    ┃\n  ◯    ┃\n       ┃\n       ┃\n       ┃\n       ┃\n" \
    "━━━━━━━┛\n"
  end

  def hangman_line6
    "  ┏━━━━┓\n  │    ┃\n  ◯    ┃\n  │    ┃\n  │    ┃\n       ┃\n       ┃\n" \
    "━━━━━━━┛\n"
  end

  def hangman_line7
    "  ┏━━━━┓\n  │    ┃\n  ◯    ┃\n  │╱   ┃\n  │    ┃\n       ┃\n       ┃\n" \
    "━━━━━━━┛\n"
  end

  def hangman_line8
    "  ┏━━━━┓\n  │    ┃\n  ◯    ┃\n ╲│╱   ┃\n  │    ┃\n       ┃\n       ┃\n" \
    "━━━━━━━┛\n"
  end

  def hangman_line9
    "  ┏━━━━┓\n  │    ┃\n  ◯    ┃\n ╲│╱   ┃\n  │    ┃\n   ╲   ┃\n       ┃\n" \
    "━━━━━━━┛\n"
  end

  def hangman_line10
    "  ┏━━━━┓\n  │    ┃\n  ◯    ┃\n ╲│╱   ┃\n  │    ┃\n ╱ ╲   ┃\n       ┃\n" \
    "━━━━━━━┛\n"
  end
end
