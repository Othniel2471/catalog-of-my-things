require 'json'
require 'date'
require_relative 'game'
require_relative 'author'

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
