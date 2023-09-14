require './item'

class MusicAlbum < Item
  attr_accessor :on_spotify, :publish_date

  def initialize(publish_date, on_spotify, genre = nil)
    publish = publish_date.split('-')
    super(Date.new(publish[0].to_i, publish[1].to_i, publish[2].to_i))
    @on_spotify = on_spotify
    self.genre = genre if genre
  end

  def can_be_archived?
    super && @on_spotify
  end
end
