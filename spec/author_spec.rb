# spec/author_spec.rb
require_relative '../author'
require_relative '../game'

describe Author do
  let(:author) { described_class.new('John', 'Doe') }
  let(:game) { Game.new('2023-01-15', true, '2023-09-15', author) }

  describe '#add_item' do
    it 'adds an item to the author' do
      author.add_item(game)
      expect(author.items).to include(game)
    end

    it 'sets the author of the added item' do
      author.add_item(game)
      expect(game.author).to eq(author)
    end
  end

  describe '#full_name' do
    it 'returns the full name of the author' do
      expect(author.full_name).to eq('John Doe')
    end
  end
end
