require_relative '../lib/hangman_input'

describe HangmanInput do
  include HangmanInput

  DUMMY_FILES = [
    '../saves/save1.save', '../saves/save43.save', '../saves/save21.save'
  ].freeze

  it 'should return input downcased' do
    allow(self).to receive(:gets).and_return('A')
    expect(input).to eq('a')

    allow(self).to receive(:gets).and_return('WoLf')
    expect(input).to eq('wolf')
  end

  it 'should return valid guess input' do
    allow(self).to receive(:input).and_return('4tab', 'L', 'i', 'Doggy', 'n')
    coded_word = 'A ien'
    expect(guess_input(coded_word)).to eq('L')
    expect(guess_input(coded_word)).to eq('Doggy')
  end

  it 'should return index of save file' do
    allow(self).to receive(:input).and_return('10', '21', '1', '3', '1043', '2')
    expect(load_input(DUMMY_FILES)).to eq(0)
    expect(load_input(DUMMY_FILES)).to eq(2)
    expect(load_input(DUMMY_FILES)).to eq(1)
  end

  it 'should return valid replay option' do
    allow(self).to receive(:input).and_return('yes', 'no', 'n', '434', 34, 'y')
    expect(replay_input).to eq('n')
    expect(replay_input).to eq('y')
  end
end
