require_relative '../music_album'

describe MusicAlbum do
  describe '#initialize' do
    it 'creates a new music album' do
      music_album = MusicAlbum.new('2020-01-01', true, Genre.new('Rock'))
      expect(music_album).to be_a(MusicAlbum)
    end
  end

  describe '#can_be_archived?' do
    it 'returns true if the music album is older than 10 years' do
      music_album = MusicAlbum.new('2000-01-01', true, Genre.new('Rock'))
      expect(music_album.can_be_archived?).to eq(true)
    end

    it 'returns false if the music album is not older than 10 years' do
      music_album = MusicAlbum.new('2020-01-01', true, Genre.new('Rock'))
      expect(music_album.can_be_archived?).to eq(false)
    end
  end

  describe '#move_to_archive' do
    it 'archives the music album if it is older than 10 years' do
      music_album = MusicAlbum.new('2000-01-01', true, Genre.new('Rock'))
      music_album.move_to_archive
      expect(music_album.archived).to eq(true)
    end

    it 'does not archive the music album if it is not older than 10 years' do
      music_album = MusicAlbum.new('2020-01-01', true, Genre.new('Rock'))
      music_album.move_to_archive
      expect(music_album.archived).to eq(false)
    end
  end
end
