require_relative '../music_album'

describe MusicAlbum do
  let(:album) { MusicAlbum.new(Date.new(2020 - 0o1 - 0o1), true) }

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
      expect(album.publish_date).to eq(Date.new(2020 - 0o1 - 0o1))
    end
  end
end
