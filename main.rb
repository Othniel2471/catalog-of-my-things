require_relative 'app'
require_relative 'modules/game_utils'
require_relative 'modules/album_utils'

puts 'Welcome to my catalog!'.center(50).upcase

def run
  main
  @game.read_authors
  @game.read_game
  @app.read_books
  @app.read_labels
end

def main
  loop do
    puts ''
    puts 'What do you want to do?'
    puts '1 - List All Books'
    puts '2 - List all music albums'
    puts '3 - List all games'
    puts "4 - List all genres (e.g 'Comedy', 'Thriller')"
    puts "5 - List all labels (e.g. 'Gift', 'New')"
    puts "6 - List all authors (e.g. 'J. K. Rowling', 'Stephen King')"
    puts '7 - Add a book'
    puts '8 - Add a music album'
    puts '9 - Add a game'
    puts '0 - Exit'
    puts ''

    option = gets.chomp.to_i
    exit if option.zero?
    list(option)

    break if option.zero?
  end
end

def list(option)
  list_main(option) if option.positive? && option < 4
  list_sub(option) if option > 3 && option < 7
  list_add(option) if option > 6 && option < 10
end

def list_main(option)
  case option
  when 1
    @app.list_books
  when 2
    @album.list_albums
  when 3
    # puts 'List all games'
    @game.list_games
  end
end

def list_sub(option)
  case option
  when 4
    @album.list_genres
  when 5
    @app.list_labels
  when 6
    @game.list_authors
    # puts "List all authors (e.g. 'J. K. Rowling', 'Stephen King')"
  end
end

def list_add(option)
  case option
  when 7
    @app.add_book
  when 8
    @album.add_music_album
  when 9
    @game.add_game
  end
end

def exit
  @app.write_book_data
  @game.write_game_data
  @game.write_author_data
  @album.write_album_data
  @album.write_genre_data
  puts 'Goodbye!'
end

@album = AlbumUtils.new
@game = GameUtils.new
@app = App.new
main
