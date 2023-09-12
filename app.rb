require './music_album'
require './genre'

class App
  def initialize
    @genres = []
    @music_albums = []
  end

  def music_album_list
    if @music_albums.empty?
      puts 'No music albums found'
    else
      @music_albums.each do |album|
        puts "Publish date: #{album.publish_date} onSpotify: #{album.on_spotify} Genre: #{album.genre.name}"
      end
    end
  end

  def genre_list
    if @genres.length.positive?
      @genres.each do |genre|
        puts "ID: #{genre.id} Genre: #{genre.name}"
      end
    else
      puts 'No genres found'
    end
  end

  def add_music_album
    puts 'On Spotify? (y/n)'
    on_spotify = gets.chomp == 'y'

    puts 'Publish Date (YYYY-MM-DD):'
    publish_date = gets.chomp

    puts 'Genre name:'
    genre_name = gets.chomp

    existing_genre = @genres.find { |genre| genre.name == genre_name }

    if existing_genre
      music_album = MusicAlbum.new(publish_date, on_spotify, existing_genre)
    else
      genre = Genre.new(genre_name)
      @genres << genre
      music_album = MusicAlbum.new(publish_date, on_spotify, genre)
    end

    @music_albums.push(music_album)
    puts 'Music Album added successfully'
  end
end
