require_relative '../game'
require_relative '../author'
require 'fileutils'

class GameUtils
  def initialize
    FileUtils.mkdir_p('Data')
    @games = []
    @authors = []
    read_game
    read_authors
  end

  def read_game
    File.new('Data/games.json', 'w') unless File.exist?('Data/games.json')
    games = File.read('Data/games.json')
    return if games.empty?

    JSON.parse(games).each do |game|
      author = Author.new(game['author']['first_name'], game['author']['last_name'])
      @games.push(Game.new(game['publish_date'], game['multiplayer'], game['last_played_at'], author))
    end
  end

  def read_authors
    File.new('Data/authors.json', 'w') unless File.exist?('Data/authors.json')
    authors = File.read('Data/authors.json')
    return if authors.empty?

    JSON.parse(authors).each do |author|
      @authors.push(
        Author.new(
          author['first_name'],
          author['last_name']
        )
      )
    end
  end

  def write_game_data
    game_file = []

    @games.each do |game|
      game_file.push(
        {
          publish_date: game.publish_date,
          multiplayer: game.multiplayer,
          last_played_at: game.last_played_at,
          author: {
            first_name: game.author.first_name,
            last_name: game.author.last_name
          }
        }
      )
    end

    write_author_data

    File.write('Data/games.json', JSON.pretty_generate(game_file))
    File.write('Data/authors.json', JSON.pretty_generate(write_author_data))
  end

  def write_author_data(author_file = [])
    @authors.each do |author|
      author_file.push(
        {
          first_name: author.first_name,
          last_name: author.last_name
        }
      )
    end
    author_file
  end

  def add_game
    print 'Enter the game\'s publish date: '
    publish_date = gets.chomp
    print 'Is the game multiplayer? (y/n) '
    multiplayer = gets.chomp
    print 'When was the game last played? '
    last_played_at = gets.chomp
    print 'Enter the author\'s first name: '
    first_name = gets.chomp
    print 'Enter the author\'s last name: '
    last_name = gets.chomp

    puts publish_date
    author = Author.new(first_name, last_name)
    @authors << author if @authors.find do |author|
      author.first_name == first_name && author.last_name == last_name
    end.nil?
    game = Game.new(publish_date, multiplayer, last_played_at)
    @games << game

    game.author = author
    puts 'Game added!'
  end

  def list_games
    puts 'No games yet' if @games.empty?
    @games.each do |game|
      puts "Publish date: #{game.publish_date}"
      puts "Multiplayer: #{game.multiplayer}"
      puts "Last played at: #{game.last_played_at}"
      puts "Author: #{game.author.first_name} #{game.author.last_name}"
      puts '---------------------'
    end
  end

  def list_authors
    puts 'No authors yet' if @authors.empty?
    @authors.each do |author|
      puts author.full_name
    end
  end
end
