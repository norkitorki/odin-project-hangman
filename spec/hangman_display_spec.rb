require_relative '../lib/hangman_display'

describe 'HangmanDisplay' do
  include HangmanDisplay

  it 'should display the instructions' do
    expect(instructions).to eq(
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
    )
  end

  context '#word_display' do
    it 'should display a clear word' do
      expect(word_display('     ')).to eq(
        <<~WORD.chomp
          ┏━━━┯━━━┯━━━┯━━━┯━━━┓
          ┃   │   │   │   │   ┃
          ┗━━━┷━━━┷━━━┷━━━┷━━━┛
        WORD
      )
    end

    it 'should display a partial word' do
      expect(word_display('S asa t')).to eq(
      <<~WORD.chomp
        ┏━━━┯━━━┯━━━┯━━━┯━━━┯━━━┯━━━┓
        ┃ S │   │ a │ s │ a │   │ t ┃
        ┗━━━┷━━━┷━━━┷━━━┷━━━┷━━━┷━━━┛
      WORD
      )
    end

    it 'should display a word' do
      expect(word_display('Seasalt')).to eq(
      <<~WORD.chomp
        ┏━━━┯━━━┯━━━┯━━━┯━━━┯━━━┯━━━┓
        ┃ S │ e │ a │ s │ a │ l │ t ┃
        ┗━━━┷━━━┷━━━┷━━━┷━━━┷━━━┷━━━┛
      WORD
      )
    end
  end

  it 'should display mismatches' do
    mismatches = %w[g j o p Car xh]
    expect(display_mismatches(mismatches)).to eq(
      "\n \e[0;31;49mg  j  o  p  Car  xh\e[0m\n\n"
    )
  end

  it 'should display a specific hangman line' do
    expect(display_hangman(1)).to eq(hangman_line1)
    expect(display_hangman(6)).to eq(hangman_line6)
    expect(display_hangman(2465)).to eq(nil)
  end

  context '#hangman_line' do
    it '1 should print the first line' do
      expect(hangman_line1).to eq('━━━━━━━')
    end

    it '2 should print the second line' do
      expect(hangman_line2).to eq(
        "       ┃\n       ┃\n       ┃\n       ┃\n       ┃\n       ┃\n━━━━━━━┛\n"
      )
    end

    it '3 should print the third line' do
      expect(hangman_line3).to eq(
        "  ━━━━━┓\n       ┃\n       ┃\n       ┃\n       ┃\n       ┃\n       ┃\n" \
        "━━━━━━━┛\n"
      )
    end

    it '4 should print the fourth line' do
      expect(hangman_line4).to eq(
        "  ┏━━━━┓\n  │    ┃\n       ┃\n       ┃\n       ┃\n       ┃\n       ┃\n" \
        "━━━━━━━┛\n"
      )
    end

    it '5 should print the fifth line' do
      expect(hangman_line5).to eq(
        "  ┏━━━━┓\n  │    ┃\n  ◯    ┃\n       ┃\n       ┃\n       ┃\n       ┃\n" \
        "━━━━━━━┛\n"
      )
    end

    it '6 should print the sixth line' do
      expect(hangman_line6).to eq(
        "  ┏━━━━┓\n  │    ┃\n  ◯    ┃\n  │    ┃\n  │    ┃\n       ┃\n       ┃\n" \
        "━━━━━━━┛\n"
      )
    end

    it '7 should print the seventh line' do
      expect(hangman_line7).to eq(
        "  ┏━━━━┓\n  │    ┃\n  ◯    ┃\n  │╱   ┃\n  │    ┃\n       ┃\n       ┃\n" \
        "━━━━━━━┛\n"
      )
    end

    it '8 should print the eighth line' do
      expect(hangman_line8).to eq(
        "  ┏━━━━┓\n  │    ┃\n  ◯    ┃\n ╲│╱   ┃\n  │    ┃\n       ┃\n       ┃\n" \
        "━━━━━━━┛\n"
      )
    end

    it '9 should print the ninth line' do
      expect(hangman_line9).to eq(
        "  ┏━━━━┓\n  │    ┃\n  ◯    ┃\n ╲│╱   ┃\n  │    ┃\n   ╲   ┃\n       ┃\n" \
        "━━━━━━━┛\n"
      )
    end

    it '10 should print the tenth line' do
      expect(hangman_line10).to eq(
        "  ┏━━━━┓\n  │    ┃\n  ◯    ┃\n ╲│╱   ┃\n  │    ┃\n ╱ ╲   ┃\n       ┃\n" \
        "━━━━━━━┛\n"
      )
    end
  end
end
