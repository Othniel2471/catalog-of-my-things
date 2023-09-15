require_relative '../music_album'

describe MusicAlbum do
  let(:date) { Date.new(2000 - 0o1 - 0o1) }
  let(:album) { MusicAlbum.new(date, true) }

  describe '#initialize' do
    it 'creates a new music album' do
      expect(album).to be_a(MusicAlbum)
    end
  end

  describe '#on_spotify' do
    it 'returns the on_spotify attribute' do
      expect(album.on_spotify).to eq(true)
    end
  end

  describe '#publish_date' do
    it 'returns the publish_date attribute' do
      expect(album.publish_date).to eq(date)
    end
  end

  describe '#can_be_archived?' do
    it 'returns true if the album is older than 10 years' do
      expect(album.can_be_archived?).to be_truthy
    end

    it 'returns false if the album is not older than 10 years and the song is on Spotify' do
      album.publish_date = Date.today
      expect(album.can_be_archived?).to be_falsey
    end
  end
end
