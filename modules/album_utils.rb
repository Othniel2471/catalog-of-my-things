require_relative '../music_album'
require_relative '../genre'

class AlbumUtils
  def initialize
    @albums = []
    @genres = []
    read_genres
    read_music_albums
  end

  def read_music_albums
    File.new('Data/music_albums.json', 'w') unless File.exist?('Data/music_albums.json')
    albums = File.read('Data/music_albums.json')
    return if albums.empty?

    JSON.parse(albums).each do |album|
      publish = album['publish_date'].split('-')
      @albums.push(MusicAlbum.new(Date.new(publish[0].to_i, publish[1].to_i, publish[2].to_i),
                                  album['on_spotify'], Genre.new(album['genre'])))
    end
  end

  def read_genres
    File.new('Data/genres.json', 'w') unless File.exist?('Data/genres.json')
    genres = File.read('Data/genres.json')
    return if genres.empty?

    JSON.parse(genres).each do |genre|
      @genres.push(Genre.new(genre['name']))
    end
  end

  def write_album_data
    album_file = []

    @albums.each do |album|
      album_file.push(
        {
          publish_date: album.publish_date,
          on_spotify: album.on_spotify,
          genre: album.genre.name
        }
      )
    end

    File.write('Data/music_albums.json', JSON.pretty_generate(album_file))
    File.write('Data/genres.json', JSON.pretty_generate(write_genre_data))
  end

  def write_genre_data
    genre_file = []

    @genres.each do |genre|
      genre_file.push(
        {
          name: genre.name
        }
      )
    end

    genre_file
  end

  def add_music_album
    puts 'On Spotify? (y/n)'
    on_spotify = gets.chomp == 'y'

    puts 'Publish Date (YYYY-MM-DD):'
    publish_date = gets.chomp
    publish = publish_date.split('-')

    puts 'Genre name:'
    genre_name = gets.chomp

    existing_genre = @genres.find { |genre| genre.name == genre_name }

    unless existing_genre
      existing_genre = Genre.new(genre_name)
      @genres << existing_genre
    end

    music_album = MusicAlbum.new(Date.new(publish[0].to_i, publish[1].to_i, publish[2].to_i), on_spotify,
                                 existing_genre)

    @albums << music_album
    puts 'Music Album added successfully'
  end

  def list_albums
    if @albums.empty?
      puts 'No music albums found'
    else
      @albums.each do |album|
        puts "Publish date: #{album.publish_date} onSpotify: #{album.on_spotify} Genre: #{album.genre.name}"
      end
    end
  end

  def list_genres
    if @genres.length.positive?
      @genres.each do |genre|
        puts "ID: #{genre.id} Genre: #{genre.name}"
      end
    else
      puts 'No genres found'
    end
  end
end
