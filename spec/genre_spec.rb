require_relative '../genre'

describe Genre do
  before(:each) do
    @genre = Genre.new('soul')
    @music_album = MusicAlbum.new(Date.new(2000 - 0o1 - 0o1), true, @genre)
  end

  describe '#initialize' do
    it 'creates a new genre' do
      expect(@genre).to be_a(Genre)
    end

    it 'should have an ID' do
      expect(@genre.id).to be_a(Integer)
    end
  end

  describe '#name' do
    it 'returns the name of the genre' do
      expect(@genre.name).to eq('soul')
    end
  end
end
