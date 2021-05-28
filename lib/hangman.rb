require_relative 'hangman_display'
require_relative 'hangman_input'
require_relative 'hangman_serialize'

# hangman console game base class
class Hangman
  attr_reader :wordlist, :secret_word, :mismatches
  attr_accessor :hidden_word

  include HangmanDisplay
  include HangmanInput
  include HangmanSerialize

  def initialize(wordlist = '../wordlists/5desk.txt')
    @wordlist = parse_wordlist(wordlist)
    reset
  end

  def play
    puts instructions
    load_game if mode_input == '2'
    system('clear')

    loop do
      break game_over if game_over?

      break save_game if mismatches.delete('save')

      turn
    end

    reset && play if replay_input == 'y'
  end

  private

  def parse_wordlist(wordlist)
    File.readlines(wordlist).select { |w| w.chomp!.length.between?(5, 12) }
  end

  def reset
    @secret_word   = wordlist.sample
    @hidden_word   = ' ' * secret_word.length
    @mismatches    = []
  end

  def turn
    puts display_hangman(mismatches.length)
    puts display_mismatches(mismatches)
    puts word_display(hidden_word)
    guess = guess_input(hidden_word)
    system('clear')
    evaluate_guess(guess)
  end

  def evaluate_guess(guess)
    return self.hidden_word = secret_word if guess == secret_word

    if guess.length == 1 && secret_word.downcase.include?(guess)
      append_letters(guess)
    else
      mismatches << guess unless mismatches.include?(guess)
    end
  end

  def append_letters(guess)
    secret_word.chars.each_with_index do |letter, i|
      hidden_word[i] = letter if letter.downcase == guess
    end
  end

  def game_over?
    hidden_word == secret_word || mismatches.length == 10
  end

  def game_over
    if hidden_word == secret_word
      puts "\e[0;32;49m#{word_display(hidden_word)}\e[0m \n" \
        'Well done! You solved the word!'
    else
      puts "#{display_hangman(mismatches.length)}\nGame Over! " \
        "The word we were looking for was #{secret_word}."
    end
  end
end

Hangman.new.play
