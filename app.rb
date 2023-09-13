require 'json'
require './music_album'
require './genre'

class App
  def initialize
    @genres = []
    @music_albums = []
    read_music_albums
    read_genres
  end

  def read_music_albums
    File.new('Data/music_albums.json', 'w') unless File.exist?('Data/music_albums.json')
    albums = File.read('Data/music_albums.json')
    return if albums.empty?

    JSON.parse(albums).each do |album|
      @music_albums.push(MusicAlbum.new(album['publish_date'], album['on_spotify'], Genre.new(album['genre'])))
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

  def write_data_music_data
    album_file = []
    genre_file = []

    @music_albums.each do |album|
      album_file.push({ publish_date: album.publish_date, on_spotify: album.on_spotify, genre: album.genre.name })
    end

    @genres.each do |genre|
      genre_file.push({ name: genre.name })
    end

    File.write('Data/music_albums.json', JSON.pretty_generate(album_file))
    File.write('Data/genres.json', JSON.pretty_generate(genre_file))
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

    unless existing_genre
      existing_genre = Genre.new(genre_name)
      @genres << existing_genre
    end

    music_album = MusicAlbum.new(publish_date, on_spotify, existing_genre)

    @music_albums << music_album
    puts 'Music Album added successfully'
    write_data_music_data
  end
end
