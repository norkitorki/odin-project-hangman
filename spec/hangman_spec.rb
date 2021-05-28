require_relative '../lib/hangman'

# unit tests for Hangman and HangmanSerialize
describe Hangman do
  include HangmanSerialize

  HangmanSerialize::SAVES_DIR = './dummy_saves'.freeze
  HangmanSerialize::MAX_SAVES = 1

  before :all do
    @hangman = Hangman.new
  end

  it 'should setup the state' do
    secret_word = @hangman.secret_word
    expect(@hangman.secret_word).to eq(secret_word)
    expect(@hangman.hidden_word).to eq(' ' * secret_word.length)
    expect(@hangman.mismatches).to eq([])
  end

  it 'should play the game' do
    allow(@hangman).to receive(:mode_input).and_return('1')
    allow(@hangman).to receive(:replay_input).and_return('n')
    @hangman.play
  end

  context '#HangmanSerialize' do
    it 'should create a save file' do
      @hangman.save_game

      fname = Time.now.strftime('./dummy_saves/hangman-%Y-%m-%d_%H-%M-%S.save')
      expect(File.exist?(fname)).to eq(true)
    end

    it 'should load a save file' do
      hangman = Hangman.new

      allow(hangman).to receive(:load_input).and_return(0)
      hangman.load_game
      expect(hangman.secret_word).to eq(@hangman.secret_word)
      expect(hangman.hidden_word).to eq(@hangman.hidden_word)
      expect(hangman.mismatches).to eq(@hangman.mismatches)
    end
  end

end
