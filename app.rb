require 'json'
require 'date'
require_relative 'game'
require_relative 'author'
require 'fileutils'
require_relative 'label'
require_relative 'book'
require './music_album'
require './genre'

class App

# Define the data directory
DATA_DIR = 'data'.freeze

# Ensure the data directory exists
FileUtils.mkdir_p(DATA_DIR)

# Load data from JSON files or create new empty arrays
def load_data
  authors_data = File.exist?('data/authors.json') ? JSON.parse(File.read('data/authors.json')) : []
  games_data = File.exist?('data/games.json') ? JSON.parse(File.read('data/games.json')) : []

  authors = authors_data.map { |author| Author.new(author['first_name'], author['last_name']) }
  games = games_data.map do |game_data|
    game = Game.new(
      Date.parse(game_data['publish_date']), # Use game_data to access the values
      game_data['multiplayer'],
      Date.parse(game_data['last_played_at']) # Use game_data to access the values
    )
    game.label = game_data['label']
    author_name = game_data['author']
    author = authors.find { |a| a.full_name.downcase == author_name.downcase } # Case-insensitive comparison
    author.add_item(game)
    game.author = author
    game.archived = game_data['archived']
    game
  end

  [authors, games]
end

# Save data to JSON files
def save_data(authors, games)
  authors_data = authors.map { |author| { 'first_name' => author.first_name, 'last_name' => author.last_name } }
  games_data = games.map do |game|
    {
      'label' => game.label,
      'publish_date' => game.publish_date.to_s,
      'multiplayer' => game.multiplayer,
      'last_played_at' => game.last_played_at.to_s,
      'author' => game.author.full_name,
      'archived' => game.archived
    }
  end

  File.write('data/authors.json', JSON.pretty_generate(authors_data))
  File.write('data/games.json', JSON.pretty_generate(games_data))
end

authors, games = load_data

def main(authors, games)
  loop do
    puts ''
    puts 'What do you want to do?'
    puts '1 - List Games'
    puts '2 - List All Authors'
    puts '3 - Add a Game'
    puts '4 - Add an Author'
    puts '0 - Exit'
    puts ''

    option = gets.chomp.to_i
    case option
    when 1
      list_games(games)
    when 2
      list_authors(authors)
    when 3
      add_game(authors, games)
    when 4
      add_author(authors)
    when 0
      save_data(authors, games) # Save data to JSON files before exiting
      exit_program
    else
      puts 'Invalid choice. Please try again.'
    end
  end
end

def list_games(games)
  puts "\nList of Games:"
  games.each do |game|
    puts "Title: #{game.label}"
    puts "Author: #{game.author.full_name}"
    puts "Publish Date: #{game.publish_date}" # Use the method to access publish date
    puts "Multiplayer: #{game.multiplayer}"
    puts "Last Played At: #{game.last_played_at}"
    puts "Archived: #{game.archived ? 'Yes' : 'No'}"
    puts '----------------------'
  end
end

def list_authors(authors)
  puts "\nList of Authors:"
  authors.each do |author|
    puts "#{author.first_name} #{author.last_name}"
  end
end

def add_game(authors, games)
  puts 'Enter Game Details:'
  print 'Title: '
  title = gets.chomp
  print 'Author\'s Full Name: '
  author_name = gets.chomp
  print 'Publish Date (YYYY-MM-DD): '
  publish_date = gets.chomp
  print 'Multiplayer (true/false): '
  multiplayer = gets.chomp.downcase == 'true'
  print 'Last Played At (YYYY-MM-DD): '
  last_played_at = gets.chomp

  author = authors.find { |a| a.full_name.downcase == author_name.downcase } # Case-insensitive comparison
  if author.nil?
    puts 'Author not found. Please add the author first.'
    return
  end

  game = Game.new(publish_date, multiplayer, last_played_at)
  game.label = title
  game.author = author
  games << game
  puts 'Game added successfully.'
end

def add_author(authors)
  puts 'Enter Author Details:'
  print 'First Name: '
  first_name = gets.chomp
  print 'Last Name: '
  last_name = gets.chomp

  author = Author.new(first_name, last_name)
  authors << author
  puts 'Author added successfully.'
end

def exit_program
  puts 'Goodbye!'
  exit
end

# Start the main menu
main(authors, games)
  def initialize
    FileUtils.mkdir_p('Data')
    @books = []
    @labels = []
    @genres = []
    @music_albums = []
    read_music_albums
    read_genres
    read_books
    read_labels
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

  def read_books
    File.new('Data/books.json', 'w') unless File.exist?('Data/books.json')
    books = File.read('Data/books.json')
    return if books.empty?

    JSON.parse(books).each do |book|
      @books.push(Book.new(book['publish_date'], book['publisher'], book['cover_state'],
                           Label.new(book['label']['title'], book['label']['color'])))
    end
  end

  def read_labels
    File.new('Data/labels.json', 'w') unless File.exist?('Data/labels.json')
    labels = File.read('Data/labels.json')
    return if labels.empty?

    JSON.parse(labels).each do |label|
      @labels.push(Label.new(label['title'], label['color']))
    end
  end

  def write_book_data
    book_file = []
    label_file = []

    @books.each do |book|
      book_file.push({ publish_date: book.publish_date, publisher: book.publisher, cover_state: book.cover_state,
                       label: { title: book.label.title, color: book.label.color } })
    end

    @labels.each do |label|
      label_file.push({ title: label.title, color: label.color })
    end

    File.write('Data/books.json', JSON.pretty_generate(book_file))
    File.write('Data/labels.json', JSON.pretty_generate(label_file))
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

  def list_books
    puts 'No books yet' if @books.empty?
    @books.each do |book|
      puts "[#{book.label.title}] Publisher: #{book.publisher} Cover State: #{book.cover_state}"
    end
  end

  def list_labels(index: false)
    puts 'No labels yet' if @labels.empty?
    puts 'Available labels:' unless index || @labels.empty?
    @labels.each_with_index do |label, idx|
      print "#{idx + 1} - " if index
      puts "[#{label.color.capitalize}] #{label.title.capitalize}"
    end
    return unless index

    puts '0 - Create a label'
    puts ''
    gets.chomp.to_i
  end

  def add_book
    print 'Publish Date (yyyy-dd-mm): '
    publish_date = gets.chomp.to_i
    print 'Publisher: '
    publisher = gets.chomp
    print 'Cover State: '
    cover_state = gets.chomp
    puts 'Choose a label:'
    label_index = list_labels(index: true)
    label = if label_index.zero?
              create_label
            else
              @labels[label_index - 1]
            end
    book = Book.new(publish_date, publisher, cover_state, label)
    label.add_item(book)
    @books << book
    puts 'Book added successfully!'
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
  end

  private

  def create_label
    print 'Title: '
    title = gets.chomp
    print 'Color: '
    color = gets.chomp
    label = Label.new(title, color)
    @labels << label
    label
  end
end
