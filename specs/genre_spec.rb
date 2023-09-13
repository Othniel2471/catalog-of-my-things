require_relative '../music_album'

describe Genre do
  describe '#initialize' do
    it 'creates a new genre' do
      genre = Genre.new('Rock')
      expect(genre).to be_a(Genre)
    end
  end
end
