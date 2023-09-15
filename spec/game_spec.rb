require 'date'
require_relative '../author'
require_relative '../game'

describe Game do
  let(:publish_date) { '2023-01-15' }
  let(:multiplayer) { true }
  let(:last_played_at) { '2020-09-15' } # Simulating a scenario where the game was last played over 2 years ago
  let(:author) { Author.new('John', 'Doe') }

  subject(:game) { described_class.new(publish_date, multiplayer, last_played_at, author) }

  describe '#can_be_archived?' do
    it 'returns true if the game was last played over 2 years ago' do
      expect(game.can_be_archived?).to be true
    end

    it 'returns false if the game was last played less than 2 years ago' do
      # Simulating a scenario where the game was last played less than 2 years ago
      game.last_played_at = Date.new(2022, 9, 15)
      expect(game.can_be_archived?).to be false
    end
  end
end
